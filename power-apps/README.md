# Field Inspection Power Apps import

This folder contains source-controlled canvas app source for the mobile inspection app. Import order:

1. Provision SharePoint lists from `/datasource/sharepoint`.
2. In Power Apps Studio, create connections to the target SharePoint site lists: `FieldIssues`, `Assets`, and `IssueAuditLog`.
3. Pack the source folder into an `.msapp` with `pac canvas pack` using `FieldInspectionApp/PACK.md`.
4. Import the app, replace connection references with the tenant's SharePoint connection, and save/publish.
5. On mobile devices, allow Camera and Location permissions. Enable formula-level error management, SaveData/LoadData support, and delayed load in app settings.

The app uses SharePoint standard connectors only. Camera images are captured into local collections for upload; production deployments should use the included Power Automate flow pattern to store binary images as attachments or in a document library and return `PhotoUrl`.
