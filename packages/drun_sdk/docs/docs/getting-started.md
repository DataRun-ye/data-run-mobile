---
title: Getting Started
slug: /getting-started
---

:::caution

D2Remote is inspired by DHIS2 Android SDK. Some of the functionalities may not yet be available as the SDK.

:::
## Installation

<!--DHIS2-SECTION-ID:installation-->

Include dependency in pubspec.yaml.

```shell

flutter pub add d2-touch

```

Install dev_dependency in pubspec.yaml.

```yml

flutter pub add -d build_runner

```

Additionally, you need to run the build_runner to allow class reflection:

```shell

flutter packages pub run build_runner build --delete-conflicting-outputs

```

## D2Remote initialization

<!--TODO-->

<!--DHIS2-SECTION-ID:initialization-->

In order to start using the SDK, the first step is to initialize to a D2Remote instance as follows:

```dart
D2RemoteInstance dRun = D2Remote.initialize(
        instance: "https://play.dhis2.org/2.36.10"
    );
```