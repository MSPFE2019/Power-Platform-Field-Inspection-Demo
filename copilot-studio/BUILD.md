# Build Oregon Facilities Assistant

1. In Copilot Studio, create a new agent named **Oregon Facilities Assistant**.
2. Use the greeting, description, and instructions in `agent.yaml`.
3. Add SharePoint knowledge for `https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo`, selecting `FieldIssues` and `Assets`.
4. Import or recreate each YAML topic in `/copilot-studio/topics`.
5. Create the `QueryIssues` Power Automate child flow from `/power-automate/QueryIssues` and add it as an action.
6. Test these deterministic questions:
   - Show all critical issues in Portland.
   - Which locations have recurring maintenance requests?
   - Which signs have been reported more than twice this year?
7. Publish to Teams or the demo website channel after confirming DLP policy allows SharePoint and Power Automate connectors.

## Exact filter logic

- Critical Portland: `City = 'Portland' AND Severity = 'Critical' AND Status NOT IN ('Resolved','Rejected')`.
- Recurring maintenance: trailing 12 months, group by `LocationAddress` or rounded lat/long bucket, return groups with count >= 3.
- Signs reported more than twice this year: `IssueType = 'Road Sign' AND ReportedDate >= startOfYear`, group by `AssetID`, return count > 2.
- Status lookup: exact `IssueID` match.
- Average resolution time: resolved rows only, `ResolvedDate - ReportedDate`, grouped by county or agency.
