# Architecture

The demo uses SharePoint as the operational data layer, a Power Apps mobile app for intake, AI Builder or Azure OpenAI for vision analysis, Power Automate for routing/escalation/digest automation, Copilot Studio for natural-language operations, and Power BI for executive reporting.

```mermaid
flowchart LR
  A[Field employee Power Apps mobile] -->|Patch + photo| B[SharePoint FieldIssues]
  B --> C[AnalyzeFieldIssue flow]
  C --> D[AI Builder or Azure OpenAI vision]
  D --> C
  C -->|Update AI fields| B
  C --> E[IssueAuditLog]
  B --> F[RequestApproval flow]
  F --> G[Teams approval]
  B --> H[CriticalIssueEscalation flow]
  H --> I[Teams channel + on-call email/SMS]
  B --> J[Copilot Studio Oregon Facilities Assistant]
  J --> K[QueryIssues child flow]
  B --> L[Power BI dashboard]
  M[Assets list] --> J
  M --> L
```
