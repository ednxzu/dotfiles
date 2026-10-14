---
name: design-doc
description: >
  Write a design document or an ADR (Architecture Decision Record) for an
  infrastructure or software change, using a fixed template and storage
  convention. Use when asked to "write a design doc", "write an ADR",
  "document this decision", "propose an architecture", or to turn a design
  discussion into a reviewable document. Covers where the file goes, which
  template to use, and the review checklist the document must pass.
---

# Design documents and ADRs

Two formats, pick by scope:

| Format | Use for | Template |
|---|---|---|
| **Design doc** | A change that needs options weighed, a rollout planned and operations thought through before building it. | `templates/design-doc.md` |
| **ADR** | Recording one decision that has been made (or is being made), so its reasoning survives. One page. | `templates/adr.md` |

If unsure, ask. A design doc often produces one or more ADRs once
decided.

## Where the file goes

Design docs live in git, next to what they describe. Never write them to
an unversioned location such as `~/Documents`.

1. **The repo already has a convention** (a `docs/design/`, `docs/adr/`,
   `doc/source/specs/`, `rfcs/`, `decisions/` folder or similar): follow it
   exactly, including numbering, file naming and format. Look before
   creating anything.
2. **The change concerns one repo with no convention:** propose
   `docs/design/YYYY-MM-DD-<slug>.md` for design docs and
   `docs/adr/NNNN-<slug>.md` for ADRs (NNNN = next free number, starting at
   0001). Ask before creating the folder.
3. **The change spans several repos, or there is no repo:** ask the user
   where the document should live. Do not pick a location yourself.

Write the file, then stop. Never commit or push: the user reviews and
commits it like any other change.

## How to write it

- Research before writing. Claims about the current system (what is
  deployed, how a component behaves, what a config sets) must come from
  reading the actual code and config, cited as `path:line` with the ref.
  Use the code-researcher method for this. Mark anything not verified as
  an assumption.
- Ask the user for what code can't tell you: goals, constraints (budget,
  hardware, people, deadlines), what is non-negotiable.
- Always include "do nothing" as an option, and give every option real
  trade-offs. A design with one option is a decision looking for
  justification.
- Prefer concrete over generic: name the hosts, services, versions, config
  keys and numbers involved.
- Keep it as short as the change allows. Delete template sections that
  genuinely don't apply, but say why in one line rather than leaving them
  empty.

## Review checklist

Before handing the document over, check it against this list and fix
gaps, or call them out as open questions:

- [ ] The problem is stated without presupposing the solution.
- [ ] Constraints and non-goals are explicit.
- [ ] At least two real options plus "do nothing", each with trade-offs.
- [ ] The decision says why the alternatives lost.
- [ ] Existing deployments: migration and upgrade path are described,
      not only the greenfield case.
- [ ] Rollback: how to undo it, and the point after which you can't.
- [ ] Failure modes: what breaks, how it's detected, blast radius.
- [ ] Operations: monitoring, alerting, capacity, who maintains it.
- [ ] Security: secrets, access, exposure, new attack surface.
- [ ] Facts about the current system are cited or marked as assumptions.
