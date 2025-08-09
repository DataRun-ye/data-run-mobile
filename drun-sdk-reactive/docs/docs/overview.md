---
title: Overview
slug: /
---

DHIS2 Flutter SDK is a library that abstracts the complexity of interacting with DHIS2 web api. It aims to be an starting point to build Flutter apps for DHIS2, covering some tasks that any Flutter app should implement, like metadata and data synchronization.

Main goals:

- **Abstract DHIS2 web api**. There is no need to perform api queries against the server. The SDK includes methods to interact with the web api.
- **Work offline**. It implements a simplified version of DHIS2 model that is persisted in a local database (SQLite). It ensures that all the metadata required to perform data entry tasks is available at any time to build the data entry forms. Data is saved locally and uploaded to the server when connection is available.
- **Ensure DHIS2 compatibility**. It encapsulates the changes between DHIS2 versions so the app does not have to care about them. In case the SDK introduces some changes to accommodate a new DHIS2 version, the app can safely detect these changes at compile-time.

## Technology overview

<!--DHIS2-SECTION-ID:technology_overview-->

The SDK is written in Dart 2 using the reduced subset of features allowed in the minimum Flutter API version. For this reason, currently **the SDK is only runnable in an Flutter environment**.

Other libraries internally used by the SDK are:  [http](https://pub.dev/packages/http) for API communication and [SQFlite](https://pub.dev/packages/sqflite) for DB migrations.