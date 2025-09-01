# NixOS Multi-Host Template

```
 _   _ _       ____   _____
| \ | (_)     / __ \ / ____|
|  \| |___  _| |  | | (___
| . ` | \ \/ / |  | |\___ \
| |\  | |>  <| |__| |____) |
|_| \_|_/_/\_\\____/|_____/  _    _           _
|  \/  |     | | | (_)      | |  | |         | |
| \  / |_   _| | |_ _ ______| |__| | ___  ___| |_
| |\/| | | | | | __| |______|  __  |/ _ \/ __| __|
| |  | | |_| | | |_| |      | |  | | (_) \__ \ |_
|_|__|_|\__,_|_|\__|_|     _|_|  |_|\___/|___/\__|
|__   __|                 | |     | |
   | | ___ _ __ ___  _ __ | | __ _| |_ ___
   | |/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \
   | |  __/ | | | | | |_) | | (_| | ||  __/
   |_|\___|_| |_| |_| .__/|_|\__,_|\__\___|
                    | |
                    |_|
```

This repository is a starting point for managing multiple NixOS machines from a single flake.
Shared settings live in reusable modules while also allowing individual host-specific overrides.

## Directory Layout

```text
.
├── flake.nix
├── README.md
├── modules/
│   ├── common.nix
│   ├── desktop.nix
│   ├── home.nix
│   └── users.nix
└── hosts/
    ├── host1/
    │   ├── configuration.nix
    │   ├── hardware-configuration.nix
    │   └── home.nix
    ├── host2/
    │   ├── configuration.nix
    │   ├── hardware-configuration.nix
    │   └── home.nix
    └── host3/
        ├── configuration.nix
        ├── hardware-configuration.nix
        └── home.nix
```

## Shared Modules

The main idea is to share configuration that is common across all hosts and use host-specific
overrides where configuration is only needed on a single host. This helps create a consistent
experience for things like CLI commands, editors, browsers, etc. To keep hosts in sync you
just need to pull down the latest config on each host and build it locally.

Every host imports the same shared system modules from `flake.nix`:

- [modules/common.nix](/home/jdysinger/Repos/nixos-multi-host-template/modules/common.nix): base settings and applications that are not tied to a particular desktop or user workflow
- [modules/desktop.nix](/home/jdysinger/Repos/nixos-multi-host-template/modules/desktop.nix): shared desktop environment, fonts, and graphical apps
- [modules/users.nix](/home/jdysinger/Repos/nixos-multi-host-template/modules/users.nix): shared user-account definitions, group membership, and account-level defaults
- [modules/home.nix](/home/jdysinger/Repos/nixos-multi-host-template/modules/home.nix): shared home-manager settings, shell setup, dotfiles, and editor tooling

## Host-specific Configuration

Each host has its own directory under `hosts/` for host-specific overrides:

- [hosts/host1/configuration.nix](/home/jdysinger/Repos/nixos-multi-host-template/hosts/host1/configuration.nix): host-specific system settings such as hostname, services, and machine-level overrides
- [hosts/host1/hardware-configuration.nix](/home/jdysinger/Repos/nixos-multi-host-template/hosts/host1/hardware-configuration.nix): generated hardware settings for disks, filesystems, and detected hardware
- [hosts/host1/home.nix](/home/jdysinger/Repos/nixos-multi-host-template/hosts/host1/home.nix): host-specific home-manager overrides for user packages and per-machine user config

## Using `/etc/nixos` As a Symlink To This Repo

The cleanest workflow is to keep the real git repo in your home directory and symlink `/etc/nixos` to it.

Example:

```bash
mkdir -p ~/Repos
git clone <your-repo-url> ~/Repos/nixos-multi-host-template
sudo mv /etc/nixos /etc/nixos.backup
sudo ln -s ~/Repos/nix-config /etc/nixos
```

## Adding a New Host

### 1. Create The Host Directory

After pulling down the repo on a new host, create a new directory under `hosts/` named after the
machine, then copy in a base set of files from another host to work with:

```bash
mkdir -p hosts/my-new-host
cp hosts/host1/configuration.nix hosts/my-new-host/
cp hosts/host1/home.nix hosts/my-new-host/
```

You also need the existing generated hardware config:

```bash
cp /etc/nixos/hardware-configuration.nix hosts/my-new-host/hardware-configuration.nix
```

### 2. Set The Hostname

In `hosts/my-new-host/configuration.nix`, set:

```nix
networking.hostName = "my-new-host";
```

## How Hosts Are Discovered

`flake.nix` reads the `hosts/` directory and creates one NixOS configuration per subdirectory.

NixOS rebuild commands target a host by name:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#$HOSTNAME
```
