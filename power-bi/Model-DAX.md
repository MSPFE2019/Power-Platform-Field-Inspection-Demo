# Power BI measures

Assume table `FieldIssues` with `ReportedDate`, `ResolvedDate`, `Status`, `Severity`, `County`, `Agency`, `IssueType`, `AssetID`, and `EstimatedCost`.

```DAX
Open Issues =
CALCULATE(COUNTROWS(FieldIssues), NOT FieldIssues[Status] IN { "Resolved", "Rejected" })

Resolved Issues =
CALCULATE(COUNTROWS(FieldIssues), FieldIssues[Status] = "Resolved")

Avg Resolution Time (days) =
AVERAGEX(
    FILTER(FieldIssues, FieldIssues[Status] = "Resolved" && NOT ISBLANK(FieldIssues[ResolvedDate])),
    DATEDIFF(FieldIssues[ReportedDate], FieldIssues[ResolvedDate], DAY)
)

Resolution SLA % =
DIVIDE(
    COUNTROWS(FILTER(FieldIssues, FieldIssues[Status] = "Resolved" && DATEDIFF(FieldIssues[ReportedDate], FieldIssues[ResolvedDate], DAY) <= 7)),
    [Resolved Issues]
)

Issues by County = COUNTROWS(FieldIssues)

Issues by Agency = COUNTROWS(FieldIssues)

Critical Open =
CALCULATE([Open Issues], FieldIssues[Severity] = "Critical")

MoM Trend =
VAR CurrentMonth = COUNTROWS(FieldIssues)
VAR PriorMonth = CALCULATE(COUNTROWS(FieldIssues), DATEADD(FieldIssues[ReportedDate], -1, MONTH))
RETURN CurrentMonth - PriorMonth

Recurring Asset Count =
COUNTROWS(
    FILTER(
        ADDCOLUMNS(SUMMARIZE(FieldIssues, FieldIssues[AssetID]), "IssueCount", CALCULATE(COUNTROWS(FieldIssues))),
        [IssueCount] >= 3 && NOT ISBLANK(FieldIssues[AssetID])
    )
)

Cost YTD =
TOTALYTD(SUM(FieldIssues[EstimatedCost]), FieldIssues[ReportedDate])
```
