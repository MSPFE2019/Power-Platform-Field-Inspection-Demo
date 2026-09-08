# Power BI executive dashboard spec

## Executive Overview

Cards: Open Issues, Critical Open, Resolved Issues, Avg Resolution Time (days), Resolution SLA %, Cost YTD. Visuals: monthly trend line, issue severity donut, county bar chart.

## Map view

Azure Maps or ArcGIS visual plotting `Latitude` and `Longitude`; color by `Severity`, size by `EstimatedCost`, tooltip with IssueID, Status, Agency, RecommendedAction.

## Agency detail

Matrix by Agency and County with Open Issues, Avg Resolution Time, SLA %, Cost YTD. Include slicers for IssueType, Severity, Status, and ReportedDate.

## Asset/recurrence detail

Table grouped by AssetID showing Issue Count, last ReportedDate, top detected condition, and total estimated cost. Highlight assets with count >= 3.

## Copilot in Power BI

Enable Copilot for Power BI in the tenant and workspace, then add a Copilot visual or use the Copilot pane with: **Summarize this month's maintenance trends.**

Fallback narrative visual text if Copilot is unavailable: "This month, maintenance demand is concentrated in recurring road sign and water issues. Critical open work is concentrated in Metro City/North County, while resolved issues show average completion within the one-week SLA for most medium and low severity requests."

