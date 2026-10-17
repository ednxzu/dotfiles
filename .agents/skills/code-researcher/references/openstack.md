# OpenStack project context

Load this alongside the main code-researcher rules when the repo is an
OpenStack project (remote on `opendev.org`, or packaging metadata naming an
`openstack` project).

## Where repos live

OpenStack repos are cloned at `~/git/opendev.org/openstack/<repo>`, for
example `~/git/opendev.org/openstack/nova` or
`~/git/opendev.org/openstack/kolla-ansible`. If the named repo isn't there,
clone it with `ghq get https://opendev.org/openstack/<repo>`, following the
cloning rules in the main skill.

Never webfetch `opendev.org`: its code browser serves agents a bot
challenge. Read code from the clone. `docs.openstack.org` and the Gerrit
REST API on `review.opendev.org` do work (see the web-sources skill).

## Refs and releases

- Service repos use `master` as the development branch (`origin/master`).
  Still confirm with `git symbolic-ref refs/remotes/origin/HEAD` rather than
  assuming.
- Stable releases live on `origin/stable/<series>` branches (for example
  `stable/2025.1`). Older series end up as `<series>-eol` tags once the
  branch is deleted. When a question is about a deployed cloud, ask which
  series it runs and read that branch, not master.
- Behavior changes between series are common. When comparing, name both
  refs and use `git log <old>..<new> -- <path>` to find the change that
  introduced the difference, then cite its commit and Change-Id.

## Extension-point catalogue

OpenStack is built almost entirely around pluggable driver and interface
patterns: assume a seam exists until the source proves otherwise. Look for:

- Entry points in `setup.cfg` / `pyproject.toml` (`[entry_points]`), loaded
  through `stevedore` namespaces. This is the standard registration
  mechanism for drivers and plugins.
- Abstract base classes intended for subclassing (driver base classes,
  `*Interface` / `*Driver` / `*Base` classes).
- oslo.config options that select a driver or backend class by name.
- oslo.messaging notifications and notification listeners, for reacting to
  events without touching service code.
- oslo.policy (`policy.yaml`) for authorization changes.
- Paste/WSGI pipeline middleware (`api-paste.ini`) for request handling.
- Service-specific seams, for example:
  - Neutron: ML2 mechanism and type drivers, service plugins
    (`neutron.service_plugins`), extensions.
  - Ironic: hardware types and hardware interfaces (management, power,
    deploy, ...), registered via entry points.
  - Nova: scheduler filters and weighers, virt drivers.
  - Cinder / Manila: volume or share backend drivers.

## Contributing upstream

When a change qualifies as an upstream contribution, it goes through Gerrit
on review.opendev.org (`git review`), not GitHub pull requests. It needs to
follow OpenStack commit conventions (imperative subject, 72-column wrap,
`Closes-Bug:` / `Depends-On:` footers where relevant), include tests, and
carry a release note (`reno new <slug>`) for user-visible changes.
