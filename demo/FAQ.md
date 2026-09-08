# Executive FAQ

## What licenses are required?

The SharePoint-backed app uses standard Microsoft 365 connectors. AI Builder, Copilot Studio, Azure OpenAI/custom connector options, and Power BI Copilot may require premium capacity, message packs, or tenant features.

## How is cost controlled?

Use seeded Power Automate triggers, bounded AI analysis per submitted issue, environment-level monitoring, and separate dev/test/prod environments. Critical demos can use AI Builder credits or an Azure OpenAI deployment with budget alerts.

## Where does the data live?

SharePoint list data and attachments live in the configured Microsoft 365 tenant region. Azure OpenAI data residency depends on the selected Azure region and enterprise data settings.

## Is this secure?

Use SharePoint permissions, least-privilege service accounts, DLP policies, connection references, and environment variables. Do not rely on app screen visibility as a security boundary.

## Is it accessible?

The app includes accessible labels, high-contrast colors, and mobile-first layouts. Validate with keyboard, screen reader, and representative devices before production.

## Does it work offline?

The canvas app uses SaveData/LoadData to queue new reports offline. SharePoint offline support is limited; production deployments should test device policy, image size, and sync conflict behavior.

## Will it scale?

For larger statewide deployments, index SharePoint columns, archive closed issues, monitor list thresholds, or move the data layer to Dataverse for richer security, relationships, and scale.

## How does this extend beyond the demo?

Add asset management integration, work orders, GIS layers, citizen intake, fleet dispatch, and governed ALM pipelines.
