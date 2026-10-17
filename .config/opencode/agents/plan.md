---
mode: primary
permissions:
  # built-in plan already denies edits outside ~/.opencode/plan; this only
  # lets it record a blocked documentation host, with approval
  - { action: edit, resource: "*/.agents/skills/web-sources/references/sources.json", effect: ask }
  - { action: shell, resource: "git push *", effect: deny }
---
