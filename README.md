# NightArch

`NightArch` is a lightweight, reproducible environment built upon Arch Linux. Think of it as a thin distribution layer: it collects your package list, configuration files, scripts and services into a single repository and provides a one‑shot installer to bootstrap a fresh Arch system into your customized environment.

## Requirements

The `NightArch` installer expects the **sudo** package to be installed and the current user to have **passwordless** **sudo** privileges. If sudo is not present or the user cannot run commands without a password, the installer will exit. Before running `NightArch` installation, make sure you:

- Install the sudo package via your package manager (e.g. pacman -Sy sudo on Arch).

- Add your user to the wheel group and configure /etc/sudoers (or /etc/sudoers.d/*) to allow passwordless sudo.

## Installation

To bootstrap `NightArch` on a fresh Arch installation, run the installer script:

```
curl -fsSL https://raw.githubusercontent.com/topchiyev/nightarch/main/install.sh | bash
```

Alternatively, clone the repository and run the installer locally:

```
git clone https://github.com/topchiyev/nightarch.git
cd nightarch
./install.sh
```

## How it works

The NightArch repository is structured with package lists (pacman and AUR), configuration files, scripts, and service definitions. The installer performs a full system update, installs your curated packages with pacman and an AUR helper (such as yay), copies your config files into place, enables services, and installs any scripts under ~/bin. This allows you to reproduce your preferred setup on any machine running Arch.

## Contributing

Feel free to fork or clone NightArch and adapt it to your needs. Contributions are welcome via pull requests.
