# Completed Work

Updated: 2026-07-25

Purpose: compact historical index only. This file is not current product,
architecture, or code authority. Use the referenced code, tests, commits, tags,
releases, and focused context maps as evidence.

## 2026-07-25

- `85414dd1`: local bulk deletion became atomic and retains any
  server-accepted or uploading submission.
- `3f3ea57b` through `6051359f`: bounded Reference catalog, field, upload, and
  picker behavior landed on `develop` and passed focused staging smoke.
- `65a5f317`: assignment-card scrolling was stabilized.

## V6 Foundation

- Production call paths, strict active/inactive classification, and agent
  onboarding were established.
- The former local SDK package was consolidated into the root package without
  changing active storage or payload contracts.
- Proven-dead source and normalized repeat/data-value persistence were removed
  through tested migrations.
- Active DI, form value/rule, validation, repeat identity/editing, locale,
  auth/session, configuration sync, error, and upload ownership were clarified
  and characterized.
- The first large-repeat phase reduced rule fan-out and dormant-row control
  memory while retaining whole-JSON persistence.
- Android/Linux tooling, signing, telemetry, release artifacts, and the
  production upgrade path were exercised for V6.

## Maintenance

- Add outcomes, not plans or explanations.
- Keep entries to one line where practical and group older entries by release.
- Do not copy implementation detail from focused maps.
- Never use this file alone to decide how current code behaves.
