# SharePoint schema

Create these lists in the target site before importing sample data. Internal names are fixed because the app, flows, Copilot topics, and Power BI queries reference them.

## FieldIssues

| Display name | Internal name | Type | Required | Notes |
|---|---|---:|:---:|---|
| Title | Title | Single line text | Yes | Short issue title |
| IssueID | IssueID | Calculated text | No | Formula: `="FI-"&TEXT(ID,"00000")` |
| IssueType | IssueType | Choice | Yes | Road Sign; Water Leak; Park Maintenance; Building Inspection; Facilities |
| Description | Description | Multiple lines text | Yes | Reporter notes |
| Photo | Attachments | Attachment | No | SharePoint list attachments enabled |
| PhotoUrl | PhotoUrl | Single line text | No | Link to uploaded/attached image for AI/Power BI |
| Latitude | Latitude | Number | Yes | 6 decimal places |
| Longitude | Longitude | Number | Yes | 6 decimal places |
| LocationAddress | LocationAddress | Single line text | No | Reverse-geocoded address |
| County | County | Choice | Yes | North County; West County; South County; Central County; River County; Mountain County |
| City | City | Single line text | Yes | city |
| Agency | Agency | Choice | Yes | ODOT; Parks & Rec; Public Works; Facilities Mgmt; Water Bureau |
| ReportedBy | ReportedBy | Person | No | Reporter |
| ReportedDate | ReportedDate | DateTime | Yes | Date/time report was submitted |
| AIAnalysis | AIAnalysis | Multiple lines text | No | Natural language AI summary |
| AIDetectedConditions | AIDetectedConditions | Multiple lines text | No | JSON/text array of detected conditions |
| Severity | Severity | Choice | Yes | Critical; High; Medium; Low |
| RecommendedPriority | RecommendedPriority | Choice | Yes | P1; P2; P3; P4 |
| RecommendedAction | RecommendedAction | Multiple lines text | No | AI or dispatcher recommendation |
| AIConfidence | AIConfidence | Number | No | Percent, 0-100 |
| Status | Status | Choice | Yes | New; AI Analyzed; Pending Approval; Approved; Assigned; In Progress; Resolved; Rejected |
| AssignedTo | AssignedTo | Person | No | Assignee |
| ApprovedBy | ApprovedBy | Person | No | Approval owner |
| ApprovalDate | ApprovalDate | DateTime | No | Approval timestamp |
| ResolvedDate | ResolvedDate | DateTime | No | Resolution timestamp |
| ResolutionNotes | ResolutionNotes | Multiple lines text | No | Closeout notes |
| EstimatedCost | EstimatedCost | Currency | No | USD estimate |
| AssetID | AssetID | Single line text | No | Joins to Assets.AssetID; used for recurrence demos |
| DuplicateOf | DuplicateOf | Lookup | No | Self-lookup to FieldIssues |

## Assets

| Display name | Internal name | Type | Required | Notes |
|---|---|---:|:---:|---|
| AssetID | AssetID | Single line text | Yes | Unique external asset key |
| AssetType | AssetType | Choice | Yes | Road Sign; Water System; Park Asset; Building; Facility |
| Description | Description | Multiple lines text | No | Asset description |
| County | County | Choice | Yes | Same county choices as FieldIssues |
| City | City | Single line text | Yes | city |
| Latitude | Latitude | Number | Yes | 6 decimal places |
| Longitude | Longitude | Number | Yes | 6 decimal places |
| InstallDate | InstallDate | DateTime | No | Install date |
| LastInspection | LastInspection | DateTime | No | Most recent inspection |
| OwningAgency | OwningAgency | Choice | Yes | ODOT; Parks & Rec; Public Works; Facilities Mgmt; Water Bureau |

## IssueAuditLog

| Display name | Internal name | Type | Required | Notes |
|---|---|---:|:---:|---|
| Title | Title | Single line text | Yes | Audit title |
| IssueID | IssueID | Lookup | Yes | Lookup to FieldIssues.IssueID |
| Action | Action | Single line text | Yes | Action name |
| PerformedBy | PerformedBy | Person | No | Actor/service account |
| Timestamp | Timestamp | DateTime | Yes | Audit timestamp |
| Details | Details | Multiple lines text | No | JSON/text details |

