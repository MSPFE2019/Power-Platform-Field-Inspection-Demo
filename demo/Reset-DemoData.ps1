[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$SiteUrl)

$ErrorActionPreference = 'Stop'
Connect-PnPOnline -Url $SiteUrl -Interactive
foreach ($list in @('IssueAuditLog','FieldIssues','Assets')) {
    Get-PnPListItem -List $list -PageSize 2000 | ForEach-Object { Remove-PnPListItem -List $list -Identity $_.Id -Force }
}
& (Join-Path $PSScriptRoot '..\datasource\sample-data\Import-SampleData.ps1') -SiteUrl $SiteUrl -DataPath (Join-Path $PSScriptRoot '..\datasource\sample-data')
Write-Host 'Demo data reset complete.'
