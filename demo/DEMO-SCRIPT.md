# 20-minute executive demo script

## 1. Mobile field report (4 min)

Click path: Power Apps mobile app > Field Inspection > New field report > capture photo > confirm GPS > choose issue type/county/agency > submit.

Talk track: "A field employee can capture the issue where they stand, with photo, GPS, and structured details instead of phone calls, email, paper, and spreadsheets."

Value driver: Power Apps MAU.

If it breaks: Use seeded FI-00001 in SharePoint and say the live capture step is represented by preloaded reports.

## 2. AI vision analysis (3 min)

Click path: SharePoint FieldIssues > open new item > show AIAnalysis, Severity, RecommendedPriority, RecommendedAction.

Talk track: "AI turns an unstructured photo into a consistent first-pass assessment, priority, and action recommendation."

Value driver: AI Builder / Copilot Usage.

If it breaks: Open `/ai/examples/sample-responses.json` and paste one response into the item to continue.

## 3. Automated routing and approvals (3 min)

Click path: Power Automate run history > RequestApproval > Teams approval card > approve.

Talk track: "The workflow routes the right work to the right agency and preserves an audit trail without manual coordination."

Value driver: Power Automate MAU/Consumption.

If it breaks: Manually set Status = Approved and show the approval README that documents the build.

## 4. Critical escalation and operations view (4 min)

Click path: Teams channel > critical issue post > email/on-call notification > SharePoint audit log.

Talk track: "Critical public safety issues bypass the normal queue so leadership and on-call teams see them immediately."

Value driver: Power Automate Consumption, Teams engagement.

If it breaks: Use seeded critical Metro City items FI-00001 to FI-00004 and show the escalation flow definition.

## 5. Facilities Assistant (3 min)

Click path: Copilot Studio test pane > ask: "Show all critical issues in Metro City." > ask recurring/sign demo questions.

Talk track: "Leaders and staff can ask operational questions in natural language, grounded in the same governed data source."

Value driver: Agent Consumption, Copilot Usage.

If it breaks: Use `/copilot-studio/expected-responses.md` as rehearsed deterministic output.

## 6. Power BI executive dashboard (3 min)

Click path: Power BI report > Executive Overview > Map view > Asset recurrence detail > Copilot prompt.

Talk track: "The same operational data becomes an executive dashboard that exposes trends, SLA risk, recurrence, and cost."

Value driver: Power BI, Copilot Usage.

If it breaks: Use the report spec and CSV files in Power BI Desktop Import Text/CSV mode.

