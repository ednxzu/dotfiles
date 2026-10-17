# dotfiles

<div align="center">

![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=archlinux&logoColor=fff&style=for-the-badge)
![mise](https://img.shields.io/badge/mise--en--place-2E2E2E?style=for-the-badge)
![bspwm](https://img.shields.io/badge/bspwm-2E2E2E?logo=bspwm&logoColor=fff&style=for-the-badge)
![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff&style=for-the-badge)

</div>

My Arch Linux setup, managed end to end by [mise-en-place](https://mise.jdx.dev):
symlinks, pacman/AUR packages, pipx tools, systemd services and units, the user
account, sudoers, and post-install hooks all live in `mise.toml` and
`.mise/conf.d/`.

The repository mirrors `$HOME`. Nothing is copied: mise symlinks files from
`~/.dotfiles` into place.

## Quick start

1. Install Arch with `archinstall` using the **Desktop / bspwm** profile, with
   bluetooth and pipewire enabled, then reboot. The bootstrap needs a running
   systemd, so it won't work from the chroot.

2. Clone the repository:

   ```bash
   sudo pacman -S git
   git clone https://github.com/ednxzu/dotfiles.git ~/.dotfiles
   ```

3. Choose which groups to apply (see [Groups](#groups)):

   ```bash
   export MISE_DOTFILES_GROUPS=desktop,dev,devops,gpu-amd,dracula
   ```

4. Bootstrap, then reboot:

   ```bash
   bash ~/.dotfiles/bootstrap.d/bootstrap.sh
   reboot
   ```

`bootstrap.sh` installs `yay`, installs mise, trusts the repository and runs
`mise bootstrap`. That step does the actual work.

## Layout

```
~/.dotfiles
├── mise.toml              # symlinks ([dotfiles]), user, group, sudoers
├── .miserc.toml           # maps $MISE_DOTFILES_GROUPS to mise envs
├── .mise/conf.d/
│   ├── mise.toml          # base: always applied
│   └── mise.<group>.toml  # applied only when <group> is selected
├── bootstrap.d/           # pre-mise shim (yay + mise install)
└── .config/ .local/ ...   # the dotfiles themselves
```

How a group gets applied:

```
hostname ──► .bashrc case ──► MISE_DOTFILES_GROUPS ──► .miserc.toml env list
                                                          │
                                                          ▼
                          .mise/conf.d/mise.toml + mise.<group>.toml ──► mise bootstrap
```

## Groups

| Group       | Contents                                                                            |
|-------------|-------------------------------------------------------------------------------------|
| *(base)*    | Core system, networking, gpg/yubikey, CLI basics, AI tooling, `dotfiles-sync` unit  |
| `desktop`   | Xorg, bspwm/sxhkd/polybar/rofi, pipewire, bluetooth, printing, apps                 |
| `dev`       | Go, Rust, Python tooling, podman, pipx tools (ansible, openstackclient, reno…)      |
| `devops`    | kubectl/helm/flux, OpenTofu, Vault/Consul, sops                                     |
| `dracula`   | Dracula GTK/icon/cursor themes and GTK4 symlinks                                    |
| `gaming`    | Steam, Wine, ntsync                                                                 |
| `gpu-amd`   | AMD microcode, mesa, Vulkan, amdgpu                                                 |
| `gpu-intel` | Intel microcode, media drivers, Vulkan                                              |
| `laptop`    | TLP, powertop, backlight, ACPI                                                      |
| `carbon`    | Host-specific: desktop machine                                                      |
| `tungsten`  | Host-specific: work laptop                                                          |

Group sets for known hosts are defined in `.bashrc`.

## Day-to-day

Re-apply after any change:

```bash
mise --cd ~/.dotfiles bootstrap
```

- **Add a package.** Add `"pacman:<pkg>"` or `"aur:<pkg>"` under
  `[bootstrap.packages]` in the right `conf.d` file.
- **Add a dotfile.** Directories such as `.config`, `.local` and `.gnupg` use
  `symlink-each` with `manifest = "git"`, so only files tracked by git get
  linked. Un-ignore the file in `.gitignore` and commit it. Top-level files need
  their own entry in `[dotfiles]` in `mise.toml`.
- **Add a machine.** Add a line to the hostname `case` in `.bashrc`, and add
  `.mise/conf.d/mise.<host>.toml` if the machine needs its own packages.
- **Sync.** The `dotfiles-sync` user unit runs
  `.config/dotfiles/dotfiles-sync.sh`, which runs `git pull` and then
  `mise bootstrap --yes`. You can also run the script by hand.

## Notes

- Assumes Arch Linux and an X11 bspwm session (polybar, rofi, picom, dunst).
- Display layouts are handled by `autorandr` (see `sxhkdrc`).
