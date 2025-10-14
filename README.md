# 🧰 Dotfiles Management with GNU Stow

<div align="center">

![Arch Linux Badge](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=archlinux&logoColor=fff&style=for-the-badge)
![GNU Bash Badge](https://img.shields.io/badge/GNU%20Bash-4EAA25?logo=gnubash&logoColor=fff&style=for-the-badge)

</div>

<div align="center">

![bspwm Badge](https://img.shields.io/badge/bspwm-2E2E2E?logo=bspwm&logoColor=fff&style=for-the-badge)&nbsp;&nbsp;
![Git Badge](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=fff&style=for-the-badge)&nbsp;&nbsp;
![VSCodium Badge](https://img.shields.io/badge/VSCodium-2F80ED?logo=vscodium&logoColor=fff&style=for-the-badge)&nbsp;&nbsp;
![Docker Badge](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=for-the-badge)&nbsp;&nbsp;
![Python Badge](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff&style=for-the-badge)

</div>

This repository contains my personal configuration files (“dotfiles”) for Arch Linux, managed using [**GNU Stow**](https://www.gnu.org/software/stow/).

The repository is structured just like your `$HOME` would be, making it easier to simply stow everything into place, and keep it synced.

## 🚀 Quick Start

### 1. Install Arch Linux

I use **archinstall** with the default **Desktop / bspwm** profile. I also enable bluetooth and the audio server (pipewire) through **archinstall**.

Once installation is complete:

```bash
reboot
```

> **Note:** A reboot is required — you need a running systemd environment for the bootstrap process to work (it won’t run correctly in the chroot).

### 2. Run the bootstrap script

Install `git`:

```bash
sudo pacman -S git
```

Clone this repository:

```bash
git clone https://github.com/ednxzu/dotfiles.git ~/.dotfiles
```

Run the bootstrap script:

```bash
bash ~/.dotfiles/bootstrap.d/bootstrap.sh
```

This will:

* Install required packages
* Set up symlinks using GNU Stow
* Configure system and user settings

The process takes around **20 minutes**. Once it finishes, reboot:

```bash
reboot
```

### 3. Configure machine-specific settings

After the bootstrap completes, copy the base configuration file:

```bash
cp ~/.dotfiles/config.sh ~/.bash_config.d/config.sh
```

Then edit `~/.bash_config.d/config.sh` to set any **machine-specific variables**, or environment overrides.

## 🧩 Repository Structure

Each top-level directory corresponds to a stow package. For example:

```
.gitconfig
.bashrc
.config/
    bspwm/
    sxhkd/
    polybar/
    dunst/
```

To stow a specific package manually (for example, only `.config`):

```bash
cd ~/.dotfiles
stow .config
```

To unstow it:

```bash
stow -D .config
```

## 🪄 Notes

* The bootstrap script assumes **Arch Linux** as a base system.
* Most configuration files are written with **bspwm**, **polybar**, and **rofi** in mind.
* You can adapt this repo to your own setup by removing or modifying directories before running the bootstrap.
* Machine-specific settings go in `~/.bash_config.d/config.sh` (not versioned in Git).
* This setup assumes you're using `autorandr` for managing display configuration (see `sxhkdrc`).
