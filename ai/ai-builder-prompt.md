# AI Builder prompt option

Name: `Analyze Field Issue Photo`

Inputs:

- `image`: photo from the SharePoint list attachment or document library file content.
- `reporterDescription`: multiline description from `FieldIssues.Description`.
- `gpsContext`: `LocationAddress`, `County`, `City`, `Latitude`, `Longitude`.

Prompt text for **Create text with GPT using a prompt**:

```text
Analyze this public-sector field maintenance photo and reporter description. Return only strict JSON with keys: issueType, detectedConditions, severity, recommendedPriority, recommendedAction, confidence, publicSafetyRisk, estimatedCost, reasoning.

Allowed issueType values: Road Sign, Water Leak, Park Maintenance, Building Inspection, Facilities.
Allowed severity values: Critical, High, Medium, Low.
Allowed recommendedPriority values: P1, P2, P3, P4.

Reporter description: {{reporterDescription}}
Location context: {{gpsContext}}

Use Critical/P1 only for immediate public safety, active flooding/leak, structural hazard, traffic control failure, or blocked emergency access. Use conservative cost estimates in USD.
```

Flow wiring:

1. Trigger on SharePoint `FieldIssues` item created.
2. Get attachments and file content for the first photo.
3. Pass the binary image input, `Description`, and GPS context into the prompt.
4. Parse the JSON output with `/ai/vision-response.schema.json`.
5. Update `AIAnalysis`, `AIDetectedConditions`, `IssueType`, `Severity`, `RecommendedPriority`, `RecommendedAction`, `AIConfidence`, and `EstimatedCost`.
