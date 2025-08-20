# Dotfiles Management with GNU Stow

This repository is structured so that all dotfiles and config directories are at the top level. You can use [GNU Stow](https://www.gnu.org/software/stow/) to symlink everything in one step.

## Quick Start

### 1. Install GNU Stow

Debian/Ubuntu:
```bash
sudo apt update
sudo apt install stow
```

### 2. Clone Your Dotfiles Repo

```bash
git clone <your-dotfiles-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

### 3. Stow Everything

Run in the repo root to symlink all dotfiles and config folders into your home directory:
```bash
stow .
```

- This links all files/folders from `.dotfiles` into your `$HOME`.
- Your `.stow-local-ignore` is used to skip files/folders you don't want stowed.

### 4. Unstow All Links

To remove all stowed symlinks:
```bash
stow -D .
```

### 5. Tips

- You can selectively stow only specific files or directories by running, e.g., `stow .bash_config.d` or `stow .config`.
- Make sure to review `.stow-local-ignore` to ensure it’s excluding what you want.

## Typical Folder Structure

```
.dotfiles/
├── .bash_config.d/
├── .bashrc
├── .config/
├── .gitconfig
├── .fonts/
├── .venvs/
└── bootstrap.d/
```
