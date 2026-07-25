# Documentation Roles And Lifecycle

Role: agent documentation guide
Status: LIVING

Purpose: help agents preserve useful repository context without turning stale
plans, chat history, or repeated findings into false authority.

## Before Writing

1. Search for the document that already owns the subject.
2. Decide the new content's role before choosing a filename.
3. Update the existing owner unless the content has a distinct role or scope.
4. Prefer a link to duplication.
5. State what was observed, what is required, and what remains pending
   separately.

## Document Roles

| Role | Use | Durable handling |
| --- | --- | --- |
| Agent instruction | Stable commands, constraints, and working rules | Keep concise in `AGENTS.md`; do not add task progress |
| Onboarding | Repository orientation and where to look next | Keep in `agents-onboarding.md`; link focused owners |
| Evidence map/reference | Active paths, ownership, classifications, and technical facts | Record evidence, confidence, and reconciliation version; revise when code changes |
| Implemented contract/policy | Behavior or compatibility that current work must preserve | State scope; change with implementation, migration analysis, and tests |
| Baseline | Check results or production state at one point | Tie to a commit, tag, command, and date; never imply it is still current without rerunning |
| Investigation/risk note | Confirmed evidence, hypotheses, measurements, and the next proof | Separate facts from hypotheses; trim or close it when the result lands |
| Proposal/plan | Intended but unfinished work | Mark `DRAFT` or pending; reconcile status after implementation; never treat it as runtime truth |
| Current work | Accepted priority and immediate sequence | Keep only in `11-current-work.md`; remove completed, stale, or unaccepted items |
| Completed history | Compact factual outcomes | Record in `12-completed-work.md` with commit/tag links; never use as current authority |

Use an architecture decision record only for a genuinely significant choice
whose alternatives, rationale, and consequences must be preserved. Do not call
an ordinary implementation contract or plan a decision record.

## Useful Status Markers

Use a short marker when the role could otherwise be misunderstood:

- `LIVING`: maintained to describe the current boundary.
- `SNAPSHOT AT <tag-or-commit>`: historical evidence from one baseline.
- `DRAFT`: proposed and non-authoritative.
- `IMPLEMENTED ON develop; ACTIVATION PENDING`: landed but not production-live.
- `HISTORICAL`: provenance only.
- `SUPERSEDED BY <document>`: retained only because replacement history matters.

## Closing Work

When a slice closes:

1. Update the focused map only if runtime evidence or ownership changed.
2. Update the contract only if protected behavior changed.
3. Remove the task from `11-current-work.md`.
4. Add one factual outcome to `12-completed-work.md` when it is worth retaining.
5. Delete or rename a draft whose role changed; do not leave a completed plan
   claiming that implementation is still missing.
6. At release, pause, or reprioritization, reconcile dates, statuses, links,
   and the last verified production baseline.

## Common Failure Modes

- Treating docs, comments, generated registrations, or names as stronger than
  active code and observed production behavior.
- Mixing current facts, future intent, and historical explanation without
  labels.
- Keeping completed checkboxes in the active backlog.
- Creating another map or summary instead of correcting the existing owner.
- Copying the same contract into onboarding, maps, plans, and work logs.
- Preserving chat chronology instead of recording the resulting evidence or
  outcome.
- Calling all reachable code core-active or all old-looking code dead.
- Letting a baseline say "current" after its commit, schema, or release changed.
- Creating speculative architecture to make a small feature look complete.
- Using an ADR process for ordinary reversible implementation work.

## External Basis

- [AGENTS.md](https://agents.md/) for stable agent-facing repository guidance.
- [Diataxis](https://diataxis.fr/start-here/) for separating reference,
  explanation, how-to guidance, and tutorials by user need.
- [GitHub Issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/about-issues)
  for mutable work that needs discussion or spans releases.
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)
  for shipped artifacts and release history.
- [AWS ADR guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/adr-process.html)
  for the narrower lifecycle of significant architectural decisions.
