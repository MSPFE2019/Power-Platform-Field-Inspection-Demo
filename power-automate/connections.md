# Connector and permission inventory

| Connector | Used by | Permission required | Notes |
|---|---|---|---|
| SharePoint Online | All flows, app, Copilot action | Read/write lists and attachments on the demo site | Use a service account or managed connection reference approved by tenant governance. |
| AI Builder / Dataverse | AnalyzeFieldIssue | Run AI prompt / AI Builder capacity | Premium licensing or AI Builder credits may apply. |
| Azure OpenAI (optional HTTP/custom connector) | AnalyzeFieldIssue alternate path | Access to deployed GPT-4 vision-capable model | Keep API keys in a connection/custom connector, not in flow definitions. |
| Approvals | RequestApproval | Create approvals | Sends actionable approval to agency manager. |
| Microsoft Teams | RequestApproval, CriticalIssueEscalation | Post adaptive cards/channel messages | Requires target team/channel membership. |
| Office 365 Outlook | RequestApproval, CriticalIssueEscalation, DailyDigest | Send mail as connection owner | Use shared mailbox where policy requires. |
| Twilio or Azure Communication Services (optional) | CriticalIssueEscalation | Send SMS | Optional; email fallback is included. |
| Power Apps | QueryIssues | Invoke child flow from Copilot Studio/Power Apps | Returns filtered/aggregate JSON for agent topics. |
