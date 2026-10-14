---
description: Download and review a Gerrit patch for kolla-ansible
agent: reviewer
---

Review Gerrit change $ARGUMENTS as a kolla-ansible core reviewer.

1. Run `git review -d $ARGUMENTS` to fetch the patch into a local branch.
2. Read the commit message with `git log -1` and evaluate it against OpenStack
   conventions (imperative subject, 72-char wrap, correct `Closes-Bug:` /
   `Depends-On:` footers).
3. Read the full diff with `git diff HEAD~1` (or the right range for a
   multi-commit series).
4. Review against the standards and known blockers in the KOLLA-ANSIBLE.md
   knowledge base (`~/.claude/KOLLA-ANSIBLE.md`).
5. Cite the exact file and line for every finding.
6. End with: commit message verdict, linting risk, and a clear
   +1 / -1 / needs-work recommendation.

If the review taught you something new and reusable about kolla-ansible
conventions or patterns, propose an addition to KOLLA-ANSIBLE.md at the end
and apply it only once I approve.
