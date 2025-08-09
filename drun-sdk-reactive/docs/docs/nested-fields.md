---
title: Nested Fields
slug: /nested-fields
---

Repositories return classes that are not an exact match of database tables: they are more complex objects that might include some properties obtained from other tables. For example, the `Event` class has a property called `trackedEntityDataValues` that include a list of TrackedEntityDataValues. The main reason to choose this kind of objects is to absorb the complexity of dealing with link tables so the app does not have to care about building links between objects.

Due to performance issues, this kind of properties are not included by default: they must be queried explicitly. In the repositories, the properties that are not included by default and need to be queried are prefixed by the keyword "with".

Several properties can be appended in the same query in any order. For example, a query like

```java
d2.programModule().programs()
    .withTrackedEntityType()
    ...
```

will return a nested `TrackedEntityType` object.