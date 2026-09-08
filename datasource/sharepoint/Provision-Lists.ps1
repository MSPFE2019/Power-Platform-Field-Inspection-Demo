<#
.SYNOPSIS
Idempotently provisions the Field Inspection demo SharePoint lists.
#>
[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$SiteUrl)

$ErrorActionPreference = 'Stop'
if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) { throw 'PnP.PowerShell is required. Run: Install-Module PnP.PowerShell -Scope CurrentUser' }
Connect-PnPOnline -Url $SiteUrl -Interactive

function Ensure-List { param([string]$Title,[switch]$EnableAttachments) $list=Get-PnPList -Identity $Title -ErrorAction SilentlyContinue; if(-not $list){$list=New-PnPList -Title $Title -Template GenericList -OnQuickLaunch}; if($EnableAttachments){Set-PnPList -Identity $Title -EnableAttachments $true|Out-Null}; $list }
function Ensure-FieldXml { param([string]$List,[string]$InternalName,[string]$Xml) if(-not (Get-PnPField -List $List -Identity $InternalName -ErrorAction SilentlyContinue)){Add-PnPFieldFromXml -List $List -FieldXml $Xml|Out-Null} }
function ChoiceXml($name,$display,$choices,$required='FALSE'){ $choiceXml=($choices|ForEach-Object{"<CHOICE>$_</CHOICE>"}) -join ''; "<Field Type='Choice' DisplayName='$display' Name='$name' StaticName='$name' Required='$required' Format='Dropdown'><CHOICES>$choiceXml</CHOICES></Field>" }

$issueTypes=@('Road Sign','Water Leak','Park Maintenance','Building Inspection','Facilities')
$counties=@('North County','West County','South County','Central County','River County','Mountain County')
$agencies=@('ODOT','Parks & Rec','Public Works','Facilities Mgmt','Water Bureau')
$severities=@('Critical','High','Medium','Low')
$priorities=@('P1','P2','P3','P4')
$statuses=@('New','AI Analyzed','Pending Approval','Approved','Assigned','In Progress','Resolved','Rejected')
$assetTypes=@('Road Sign','Water System','Park Asset','Building','Facility')

Ensure-List -Title 'FieldIssues' -EnableAttachments|Out-Null
Ensure-List -Title 'Assets'|Out-Null
Ensure-List -Title 'IssueAuditLog'|Out-Null

Ensure-FieldXml 'FieldIssues' 'IssueID' "<Field Type='Calculated' ResultType='Text' DisplayName='IssueID' Name='IssueID' StaticName='IssueID'><Formula>=&quot;FI-&quot;&amp;TEXT(ID,&quot;00000&quot;)</Formula><FieldRefs><FieldRef Name='ID' /></FieldRefs></Field>"
Ensure-FieldXml 'FieldIssues' 'IssueType' (ChoiceXml 'IssueType' 'IssueType' $issueTypes 'TRUE')
Ensure-FieldXml 'FieldIssues' 'Description' "<Field Type='Note' DisplayName='Description' Name='Description' StaticName='Description' Required='TRUE' NumLines='6' RichText='FALSE' />"
Ensure-FieldXml 'FieldIssues' 'PhotoUrl' "<Field Type='Text' DisplayName='PhotoUrl' Name='PhotoUrl' StaticName='PhotoUrl' />"
Ensure-FieldXml 'FieldIssues' 'Latitude' "<Field Type='Number' DisplayName='Latitude' Name='Latitude' StaticName='Latitude' Required='TRUE' Decimals='6' />"
Ensure-FieldXml 'FieldIssues' 'Longitude' "<Field Type='Number' DisplayName='Longitude' Name='Longitude' StaticName='Longitude' Required='TRUE' Decimals='6' />"
Ensure-FieldXml 'FieldIssues' 'LocationAddress' "<Field Type='Text' DisplayName='LocationAddress' Name='LocationAddress' StaticName='LocationAddress' />"
Ensure-FieldXml 'FieldIssues' 'County' (ChoiceXml 'County' 'County' $counties 'TRUE')
Ensure-FieldXml 'FieldIssues' 'City' "<Field Type='Text' DisplayName='City' Name='City' StaticName='City' Required='TRUE' />"
Ensure-FieldXml 'FieldIssues' 'Agency' (ChoiceXml 'Agency' 'Agency' $agencies 'TRUE')
Ensure-FieldXml 'FieldIssues' 'ReportedBy' "<Field Type='User' DisplayName='ReportedBy' Name='ReportedBy' StaticName='ReportedBy' UserSelectionMode='PeopleOnly' />"
Ensure-FieldXml 'FieldIssues' 'ReportedDate' "<Field Type='DateTime' DisplayName='ReportedDate' Name='ReportedDate' StaticName='ReportedDate' Required='TRUE' Format='DateTime' />"
Ensure-FieldXml 'FieldIssues' 'AIAnalysis' "<Field Type='Note' DisplayName='AIAnalysis' Name='AIAnalysis' StaticName='AIAnalysis' NumLines='8' RichText='FALSE' />"
Ensure-FieldXml 'FieldIssues' 'AIDetectedConditions' "<Field Type='Note' DisplayName='AIDetectedConditions' Name='AIDetectedConditions' StaticName='AIDetectedConditions' NumLines='5' RichText='FALSE' />"
Ensure-FieldXml 'FieldIssues' 'Severity' (ChoiceXml 'Severity' 'Severity' $severities 'TRUE')
Ensure-FieldXml 'FieldIssues' 'RecommendedPriority' (ChoiceXml 'RecommendedPriority' 'RecommendedPriority' $priorities 'TRUE')
Ensure-FieldXml 'FieldIssues' 'RecommendedAction' "<Field Type='Note' DisplayName='RecommendedAction' Name='RecommendedAction' StaticName='RecommendedAction' NumLines='6' RichText='FALSE' />"
Ensure-FieldXml 'FieldIssues' 'AIConfidence' "<Field Type='Number' DisplayName='AIConfidence' Name='AIConfidence' StaticName='AIConfidence' Min='0' Max='100' Decimals='0' />"
Ensure-FieldXml 'FieldIssues' 'Status' (ChoiceXml 'Status' 'Status' $statuses 'TRUE')
Ensure-FieldXml 'FieldIssues' 'AssignedTo' "<Field Type='User' DisplayName='AssignedTo' Name='AssignedTo' StaticName='AssignedTo' UserSelectionMode='PeopleOnly' />"
Ensure-FieldXml 'FieldIssues' 'ApprovedBy' "<Field Type='User' DisplayName='ApprovedBy' Name='ApprovedBy' StaticName='ApprovedBy' UserSelectionMode='PeopleOnly' />"
Ensure-FieldXml 'FieldIssues' 'ApprovalDate' "<Field Type='DateTime' DisplayName='ApprovalDate' Name='ApprovalDate' StaticName='ApprovalDate' Format='DateTime' />"
Ensure-FieldXml 'FieldIssues' 'ResolvedDate' "<Field Type='DateTime' DisplayName='ResolvedDate' Name='ResolvedDate' StaticName='ResolvedDate' Format='DateTime' />"
Ensure-FieldXml 'FieldIssues' 'ResolutionNotes' "<Field Type='Note' DisplayName='ResolutionNotes' Name='ResolutionNotes' StaticName='ResolutionNotes' NumLines='6' RichText='FALSE' />"
Ensure-FieldXml 'FieldIssues' 'EstimatedCost' "<Field Type='Currency' DisplayName='EstimatedCost' Name='EstimatedCost' StaticName='EstimatedCost' LCID='1033' Decimals='2' />"
Ensure-FieldXml 'FieldIssues' 'AssetID' "<Field Type='Text' DisplayName='AssetID' Name='AssetID' StaticName='AssetID' />"
$fieldIssues=Get-PnPList -Identity 'FieldIssues'
Ensure-FieldXml 'FieldIssues' 'DuplicateOf' "<Field Type='Lookup' DisplayName='DuplicateOf' Name='DuplicateOf' StaticName='DuplicateOf' List='{$($fieldIssues.Id)}' ShowField='Title' />"

Ensure-FieldXml 'Assets' 'AssetID' "<Field Type='Text' DisplayName='AssetID' Name='AssetID' StaticName='AssetID' Required='TRUE' Indexed='TRUE' />"
Ensure-FieldXml 'Assets' 'AssetType' (ChoiceXml 'AssetType' 'AssetType' $assetTypes 'TRUE')
Ensure-FieldXml 'Assets' 'Description' "<Field Type='Note' DisplayName='Description' Name='Description' StaticName='Description' NumLines='6' RichText='FALSE' />"
Ensure-FieldXml 'Assets' 'County' (ChoiceXml 'County' 'County' $counties 'TRUE')
Ensure-FieldXml 'Assets' 'City' "<Field Type='Text' DisplayName='City' Name='City' StaticName='City' Required='TRUE' />"
Ensure-FieldXml 'Assets' 'Latitude' "<Field Type='Number' DisplayName='Latitude' Name='Latitude' StaticName='Latitude' Required='TRUE' Decimals='6' />"
Ensure-FieldXml 'Assets' 'Longitude' "<Field Type='Number' DisplayName='Longitude' Name='Longitude' StaticName='Longitude' Required='TRUE' Decimals='6' />"
Ensure-FieldXml 'Assets' 'InstallDate' "<Field Type='DateTime' DisplayName='InstallDate' Name='InstallDate' StaticName='InstallDate' Format='DateOnly' />"
Ensure-FieldXml 'Assets' 'LastInspection' "<Field Type='DateTime' DisplayName='LastInspection' Name='LastInspection' StaticName='LastInspection' Format='DateOnly' />"
Ensure-FieldXml 'Assets' 'OwningAgency' (ChoiceXml 'OwningAgency' 'OwningAgency' $agencies 'TRUE')
Ensure-FieldXml 'IssueAuditLog' 'IssueID' "<Field Type='Lookup' DisplayName='IssueID' Name='IssueID' StaticName='IssueID' List='{$($fieldIssues.Id)}' ShowField='IssueID' Required='TRUE' />"
Ensure-FieldXml 'IssueAuditLog' 'Action' "<Field Type='Text' DisplayName='Action' Name='Action' StaticName='Action' Required='TRUE' />"
Ensure-FieldXml 'IssueAuditLog' 'PerformedBy' "<Field Type='User' DisplayName='PerformedBy' Name='PerformedBy' StaticName='PerformedBy' UserSelectionMode='PeopleOnly' />"
Ensure-FieldXml 'IssueAuditLog' 'Timestamp' "<Field Type='DateTime' DisplayName='Timestamp' Name='Timestamp' StaticName='Timestamp' Required='TRUE' Format='DateTime' />"
Ensure-FieldXml 'IssueAuditLog' 'Details' "<Field Type='Note' DisplayName='Details' Name='Details' StaticName='Details' NumLines='8' RichText='FALSE' />"
Write-Host 'Provisioning complete.'

