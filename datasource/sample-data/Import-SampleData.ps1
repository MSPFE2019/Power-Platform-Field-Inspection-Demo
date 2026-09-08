<#
.SYNOPSIS
Imports deterministic demo seed data into the provisioned SharePoint lists.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$SiteUrl,
    [string]$DataPath = (Split-Path -Parent $MyInvocation.MyCommand.Path)
)

$ErrorActionPreference = 'Stop'
Connect-PnPOnline -Url $SiteUrl -Interactive

function Upsert-ListItemByKey {
    param([string]$List, [string]$KeyField, [string]$KeyValue, [hashtable]$Values)
    $existing = Get-PnPListItem -List $List -PageSize 2000 | Where-Object { $_[$KeyField] -eq $KeyValue } | Select-Object -First 1
    if ($existing) {
        Set-PnPListItem -List $List -Identity $existing.Id -Values $Values | Out-Null
        return $existing.Id
    }
    return (Add-PnPListItem -List $List -Values $Values).Id
}

$assets = Import-Csv (Join-Path $DataPath 'Assets.csv')
foreach ($row in $assets) {
    Upsert-ListItemByKey -List 'Assets' -KeyField 'AssetID' -KeyValue $row.AssetID -Values @{
        Title=$row.AssetID; AssetID=$row.AssetID; AssetType=$row.AssetType; Description=$row.Description; County=$row.County; City=$row.City;
        Latitude=[double]$row.Latitude; Longitude=[double]$row.Longitude; InstallDate=$row.InstallDate; LastInspection=$row.LastInspection; OwningAgency=$row.OwningAgency
    } | Out-Null
}

$issueIdToItemId = @{}
$issues = Import-Csv (Join-Path $DataPath 'FieldIssues.csv')
foreach ($row in $issues) {
    $values = @{
        Title=$row.Title; IssueType=$row.IssueType; Description=$row.Description; PhotoUrl=$row.PhotoUrl; Latitude=[double]$row.Latitude; Longitude=[double]$row.Longitude;
        LocationAddress=$row.LocationAddress; County=$row.County; City=$row.City; Agency=$row.Agency; ReportedDate=$row.ReportedDate; AIAnalysis=$row.AIAnalysis;
        AIDetectedConditions=$row.AIDetectedConditions; Severity=$row.Severity; RecommendedPriority=$row.RecommendedPriority; RecommendedAction=$row.RecommendedAction;
        AIConfidence=[int]$row.AIConfidence; Status=$row.Status; ApprovalDate=$row.ApprovalDate; ResolvedDate=$row.ResolvedDate; ResolutionNotes=$row.ResolutionNotes;
        EstimatedCost=[double]$row.EstimatedCost; AssetID=$row.AssetID
    }
    $id = Upsert-ListItemByKey -List 'FieldIssues' -KeyField 'Title' -KeyValue $row.Title -Values $values
    $issueIdToItemId[$row.IssueID] = $id
}

foreach ($row in $issues | Where-Object { $_.DuplicateOf }) {
    $itemId = $issueIdToItemId[$row.IssueID]
    $dupId = $issueIdToItemId[$row.DuplicateOf]
    if ($itemId -and $dupId) { Set-PnPListItem -List 'FieldIssues' -Identity $itemId -Values @{ DuplicateOf = $dupId } | Out-Null }
}

Write-Host "Imported $($assets.Count) assets and $($issues.Count) field issues."
