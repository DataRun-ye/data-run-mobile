---
title: Filters
slug: /filters
---

Repositories expose the list of available filters prefixed by the keyword "by". The list of filter operators available for each filter is dependant on the filter value type: for example, a value type `Date` will offer operators like `after`, `before`, `inPeriods`, while a value type `Boolean` will offer `isFalse` or `isTrue`.

Several filters can be appended to the same query in any order. Filters are joined globally using the operator "AND". This means that a query like

```java
D2Remote.eventModule().events()
    .byOrganisationUnitUid().eq("DiszpKrYNg8")
    .byEventDate().after(Date("2019-05-05"))
    ...
```

will return the events assigned to the orgunit "DiszpKrYNg8" **AND** whose eventDate is after "2019-05-05".