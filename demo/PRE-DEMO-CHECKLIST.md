# Pre-demo checklist

## T-24 hours

1. Confirm Power Platform environment, SharePoint site, Power BI workspace, Teams team/channel, and licensing.
2. Run `/datasource/sharepoint/Provision-Lists.ps1`.
3. Run `/datasource/sample-data/Import-SampleData.ps1`.
4. Import/publish the Power Apps app and flows.
5. Build the Copilot Studio agent and test the three deterministic questions.
6. Build the Power BI report from `/power-bi` and refresh.

## T-15 minutes

1. Run the reset script below.
2. Confirm phone camera/location permissions.
3. Confirm Teams channel and approval mailbox are open.
4. Confirm Power BI report refresh succeeded.
5. Keep `/copilot-studio/expected-responses.md` open as recovery notes.

## Clean reset

Run:

```powershell
.\demo\Reset-DemoData.ps1 -SiteUrl https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo
```
