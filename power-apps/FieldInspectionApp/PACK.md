# Packing the canvas app

Prerequisites:

```powershell
pac auth create --url https://make.powerapps.com/environments/<ENVIRONMENT-ID>
pac canvas pack --sources .\power-apps\FieldInspectionApp --msapp .\exports\FieldInspectionApp.msapp
```

Import `exports\FieldInspectionApp.msapp` in Power Apps Studio, then reconnect the SharePoint data sources to the provisioned `FieldIssues`, `Assets`, and `IssueAuditLog` lists.

If `pac canvas pack` reports schema drift, create a blank phone canvas app, save it locally with the same Power Platform CLI version, unpack it with `pac canvas unpack`, then copy the formulas from `Src\` into the generated source tree.
