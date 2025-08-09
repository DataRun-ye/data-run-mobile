---
title: Query Builder
slug: /query-builder
---

Repositories offer a builder syntax with compile-time validation to access the resources. A typical query is composed of some modifiers (filter, order, nested fields) and ends with an action (get, count, getPaged,...).

```java
// Generic syntax
D2Remote.<module>.<repository>
    .[ filter | orderBy | nested fields ]
    .<action>;

// An example for events
D2Remote.eventModule().events()
    .byOrganisationUnitUid().eq("DiszpKrYNg8")
    .byEventDate().after(Date("2019-05-05"))
    .orderByEventDate(DESC)
    .withTrackedEntityDataValues()
    .get();
```