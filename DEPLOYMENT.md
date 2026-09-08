# Deployment guide

## Prerequisites

- Microsoft 365 tenant with SharePoint Online and Teams.
- Power Platform environment with permission to create apps, flows, connection references, and Copilot Studio agents.
- Power BI Pro or Fabric workspace for report publishing.
- Optional: AI Builder credits or Azure OpenAI GPT-4 vision-capable deployment.
- PowerShell 7+, PnP.PowerShell, and Power Platform CLI (`pac`).

## Placeholder tokens

Replace these everywhere during deployment:

| Token | Meaning |
|---|---|
| `<YOUR-TENANT>` | Tenant DNS prefix, e.g. contoso |
| `<ENVIRONMENT-ID>` | Power Platform environment ID |
| `<TEAMS-CHANNEL-ID>` | Target Teams channel/conversation ID |
| `agency.manager@<YOUR-TENANT>.onmicrosoft.com` | Approval owner |
| `dispatcher@<YOUR-TENANT>.onmicrosoft.com` | Dispatch user |
| `oncall@<YOUR-TENANT>.onmicrosoft.com` | On-call recipient |
| `leadership@<YOUR-TENANT>.onmicrosoft.com` | Daily digest recipient |

## Deployment order

1. Create SharePoint site: `https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo`.
2. Provision lists: `.\datasource\sharepoint\Provision-Lists.ps1 -SiteUrl https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo`.
3. Import sample data: `.\datasource\sample-data\Import-SampleData.ps1 -SiteUrl https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo`.
4. Pack/import the canvas app from `/power-apps/FieldInspectionApp` and reconnect SharePoint data sources.
5. Choose AI Builder or Azure OpenAI. Configure the prompt in `/ai` and update `AnalyzeFieldIssue`.
6. Create/import flows in a Power Platform solution using `/power-automate` folders. Replace tokens and connection references.
7. Create the Copilot Studio agent with `/copilot-studio/BUILD.md`.
8. Build the Power BI report using `/power-bi/PowerQuery.m`, `/power-bi/Model-DAX.md`, and `/power-bi/REPORT-SPEC.md`.
9. Run `/demo/PRE-DEMO-CHECKLIST.md` before presenting.

## Troubleshooting

- SharePoint field mismatch: rerun `Provision-Lists.ps1`; it is idempotent for missing fields.
- Flow import connector errors: rebuild manually from each flow README and keep the same action names where possible.
- AI output parse failure: lower creativity/temperature and enforce `/ai/vision-response.schema.json`.
- App cannot save offline: confirm mobile player supports SaveData/LoadData and device storage is allowed.
- Power BI date measures blank: ensure `ReportedDate` and `ResolvedDate` are typed as datetime in Power Query.
- Copilot answer inconsistent: route deterministic questions through `QueryIssues`, not free-form knowledge search.
