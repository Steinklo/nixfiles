# nixfiles

NixOS configuration for my desktop, managed with [flakes](https://wiki.nixos.org/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

## Structure

```
.
├── flake.nix                    # Entrypoint — defines inputs and system config
├── flake.lock                   # Pinned dependency versions
├── home/
│   └── home.nix                 # User packages and config (home-manager)
└── system/
    ├── configuration.nix        # System-level config (desktop, drivers, services)
    └── hardware-configuration.nix
```

- **system/** — everything that needs root: desktop environment, NVIDIA drivers, keyd, audio, networking
- **home/** — user-level packages and dotfiles: dev tools, apps, git config

## Hardware

- AMD Ryzen CPU
- NVIDIA GPU (proprietary drivers)
- NVMe + SATA storage

## Software

- **Desktop:** KDE Plasma 6 with SDDM
- **Audio:** PipeWire
- **Shell:** bash
- **Editor:** Neovim / VS Code
- **Gaming:** Steam, Lutris

## Usage

Rebuild after making changes:

```bash
cd ~/nixfiles
sudo nixos-rebuild switch --flake .#steinklo
```

Update inputs (nixpkgs, home-manager):

```bash
nix flake update
sudo nixos-rebuild switch --flake .#steinklo
```
