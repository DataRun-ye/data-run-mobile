# Current Work

Updated: 2026-07-25

Purpose: hold only accepted current and queued work. This file is not a product,
architecture, or code authority. Revalidate every item against production,
active code, tests, and its focused context map before acting.

## Now: Close Mobile `6.0.2`

1. Set `6.0.2` with a build number above the highest Play build.
2. Run focused and full checks, then build the signed production AAB.
3. Upgrade-smoke on Redmi: ordinary sync/forms, Reference selection/create/
   reopen/upload against staging, protected local deletion, and assignment
   scrolling.
4. Merge the tested commit to `main`, tag it, retain artifacts, and publish the
   same AAB.
5. Reconcile the production baseline in `09`, update Reference status in `10`,
   and move the release outcome to `12`.

## Next: Reference Production Activation

1. Deploy the additive server Reference commits without assigning a Reference
   form.
2. Smoke existing configuration and submission payloads and verify old/new
   client assignment filtering.
3. Import the catalog and activate only a test assignment.
4. Complete the activation gates in `10` before enabling campaign access.

## Then: Operational UX

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
