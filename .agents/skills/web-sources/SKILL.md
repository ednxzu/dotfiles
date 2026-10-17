---
name: web-sources
description: >
  Registry of documentation and code hosts that block or degrade agent
  fetches, and what to do instead. Use before fetching docs, source files or
  API data from a project website, and whenever a fetch returns a bot
  challenge, Cloudflare page, login wall, 403, or an empty or truncated page.
  Also use to record a newly discovered blocked host so later sessions skip
  it.
---

# Web sources

Fetching a page a host will never serve to an agent wastes steps. Check the
registry first, and record every persistent block you discover.

## Before fetching

Look the host up (exact hostname, no scheme or path):

```bash
jq -r '.["<host>"] // empty' ~/.agents/skills/web-sources/references/sources.json
```

- No output: the host isn't listed. Fetch normally.
- `"status": "blocked"`: never fetch it. Follow `do`.
- `"status": "degraded"`: it works only in the way `do` describes.
- `"status": "ok"`: it works; `do` holds a tip (an API endpoint, a format
  quirk).

## When a fetch fails

Tell a persistent block (bot challenge, Cloudflare "just a moment", Anubis
"making sure you're not a bot", login wall, consistent 403) from a one-off
failure (timeout, 5xx). Retry a one-off failure once; record only persistent
blocks.

Fallbacks, in order:

1. **Local clone.** Most project docs are built from the repo (`doc/`,
   `docs/`, `README*`). Find it with `ghq list -p <repo>`; if missing, clone
   it with `ghq get <repo-url>` (or, without ghq,
   `git clone <repo-url> ~/git/<host>/<owner>/<repo>`). Read files with
   `git -C <repo> show <ref>:<path>` rather than checking out branches.
2. **A mirror** that serves raw files, such as
   `raw.githubusercontent.com/<owner>/<repo>/<ref>/<path>`.
3. **The project's API** instead of its web UI (Gerrit REST, forge APIs).
4. **Local CLI help**, which beats any website when it exists:
   `ansible-doc <module>`, `<tool> --help`, `man <tool>`.

## Recording a host

Add or update one entry in `references/sources.json` (the edit asks for
approval; the user commits it). One key per exact hostname: a block on
`opendev.org` says nothing about `review.opendev.org`.

```json
"<host>": {
  "status": "blocked | degraded | ok",
  "do": "<how the block shows up, then what to use instead, concrete enough to act on>",
  "checked": "<YYYY-MM-DD>"
}
```

Only list a host when there is something useful to say about it, never just
"it works". When an entry turns out to be wrong (a blocked host now serves
pages), update `status`, `do` and `checked` rather than deleting it. Keep
the file sorted by key.

Webfetch for a blocked host should also be denied in the shared
`permissions` of `~/.config/opencode/opencode.json`; when you add a
`blocked` entry, tell the user to add the matching deny rule.
