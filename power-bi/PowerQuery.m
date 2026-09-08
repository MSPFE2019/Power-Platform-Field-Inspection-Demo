let
    SiteUrl = "https://<YOUR-TENANT>.sharepoint.com/sites/FieldInspectionDemo",
    Source = SharePoint.Tables(SiteUrl, [Implementation="2.0", ViewMode="All"]),
    FieldIssuesRaw = Source{[Title="FieldIssues"]}[Items],
    FieldIssues = Table.TransformColumnTypes(FieldIssuesRaw, {
        {"ReportedDate", type datetime}, {"ResolvedDate", type datetime}, {"ApprovalDate", type datetime},
        {"Latitude", type number}, {"Longitude", type number}, {"AIConfidence", Int64.Type}, {"EstimatedCost", Currency.Type}
    }),
    AssetsRaw = Source{[Title="Assets"]}[Items],
    Assets = Table.TransformColumnTypes(AssetsRaw, {
        {"Latitude", type number}, {"Longitude", type number}, {"InstallDate", type date}, {"LastInspection", type date}
    })
in
    FieldIssues
