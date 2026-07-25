# Current Work

Updated: 2026-07-25

Purpose: hold only accepted current and queued work. This file is not a product,
architecture, or code authority. Revalidate every item against production,
active code, tests, and its focused context map before acting.

## Now: Reference Production Activation

- Shared sequence and compatibility state:
  [DataRun API #34](https://github.com/DataRun-ye/data-run-api/issues/34).
- Mobile-owned verification:
  [DataRun Mobile #33](https://github.com/DataRun-ye/data-run-mobile/issues/33).
- The server deployment task must close before the mobile test assignment is
  activated. Keep the detailed sequence in the shared issue and the durable
  contract in `10-bounded-reference-field-plan.md`.

## Next: Operational UX

1. Add a local read-only work projection without a schema or server change.
2. Replace the activity-only home with direct access to drafts, attention
   states, assignments, forms, and new entry.
3. Add a global local Records view for Draft, Ready to send, Needs attention,
   and Sent records.
4. Consolidate assignment details and form selection into one workspace using
   proven `assignment_forms` permissions.
5. Clarify form draft, review, and finalize actions.
6. Improve repeat summaries, rapid-entry actions, and invalid-row navigation.
7. Separate configuration refresh from submission upload and finish
   operational localization.
8. Remove superseded navigation only after replacement paths pass device smoke.

## Parked Policy Work

- Server-authoritative edit/delete for accepted submissions.
- Offline delete authorization, audit/tombstone, conflict, and retry.
- Synced-record cache retention after a safe reconstruction path exists.
- Historical-record visibility after activity, assignment, team, or access
  changes.

## Maintenance

- Keep this file ordered and short; do not retain completed checkboxes.
- When work closes, remove it here and add one factual line to
  `12-completed-work.md`.
- Put implementation evidence in code, tests, commits, and the focused map.
- Put an implemented contract in its focused context document and link it from
  the owning evidence map; do not record it here.
- Move an unresolved item to a GitHub issue when it needs discussion or spans
  releases; leave only a short link here if it remains prioritized.
- At each release, pause, or reprioritization, remove completed, stale, and
  unaccepted items and update the date.
