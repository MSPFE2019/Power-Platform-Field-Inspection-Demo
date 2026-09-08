# RequestApproval

## Trigger

SharePoint item modified when `Status = AI Analyzed`.

## Connections

- SharePoint Online for `FieldIssues`, `Assets`, and `IssueAuditLog`.
- AI Builder or Azure OpenAI/custom connector where AI analysis is required.
- Approvals, Microsoft Teams, and Office 365 Outlook where listed in the flow definition.

## Build guide

1. Create this flow inside a Power Platform solution.
2. Add the trigger above and point SharePoint actions at `https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo`.
3. Recreate actions from `definition.json` in order, replacing placeholder tokens documented in `/DEPLOYMENT.md`.
4. Use solution connection references rather than hard-coded personal connections.
5. Test with seeded SharePoint data, then turn on the flow.

If direct import fails because connector operation IDs differ by tenant, rebuild manually from this README and the action names in `definition.json`.
