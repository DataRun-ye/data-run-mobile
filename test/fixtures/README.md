# Form Fixtures

`live_forms/` is the current local form-config fixture set. It was copied from
the test tablet's schema-5 database after configuration sync on 2026-07-22.
It contains form templates, template versions, and only their referenced option
metadata. It contains no users, credentials, assignments, or submissions.

`live_forms/manifest.json` records the captured app/schema versions and every
template version. Runtime/server configuration remains authoritative if it is
newer than this dated snapshot.

`legacy_forms/` and `legacy_submissions/` contain the former `example/` files.
They are historical fixtures, not evidence of current production configuration.
The ITNs pair remains useful for the large-repeat stress harness.
