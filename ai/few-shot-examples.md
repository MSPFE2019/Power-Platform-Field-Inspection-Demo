# Few-shot examples

## Broken stop sign

Input: image shows a stop sign bent away from traffic near a busy intersection.

Output:
```json
{"issueType":"Road Sign","detectedConditions":["structural damage","traffic control failure"],"severity":"Critical","recommendedPriority":"P1","recommendedAction":"Dispatch ODOT or Public Works crew immediately to secure the intersection and replace or temporarily mount the stop sign.","confidence":93,"publicSafetyRisk":true,"estimatedCost":1200,"reasoning":"A damaged stop sign can cause immediate traffic safety risk."}
```

## Graffitied park bench

Output:
```json
{"issueType":"Park Maintenance","detectedConditions":["graffiti","cosmetic damage"],"severity":"Low","recommendedPriority":"P4","recommendedAction":"Schedule parks maintenance to clean graffiti and inspect bench hardware during the next routine route.","confidence":88,"publicSafetyRisk":false,"estimatedCost":275,"reasoning":"Graffiti is visible but no immediate safety hazard is apparent."}
```

## Water pooling on sidewalk

Output:
```json
{"issueType":"Water Leak","detectedConditions":["standing water","possible underground leak","trip hazard"],"severity":"High","recommendedPriority":"P2","recommendedAction":"Send Water Bureau crew to isolate leak source, mark pedestrian hazard, and repair line if confirmed.","confidence":84,"publicSafetyRisk":true,"estimatedCost":3500,"reasoning":"Standing water on a pedestrian route creates slip risk and may indicate an active leak."}
```
