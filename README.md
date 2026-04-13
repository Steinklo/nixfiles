# nixfiles

My NixOS desktop config — [Hyprland](https://hyprland.org/) on Wayland with NVIDIA, managed with [flakes](https://wiki.nixos.org/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

**System:** PipeWire, greetd + tuigreet, keyd (Norwegian remapping), Steam/Lutris

**Desktop:** Kitty, wofi, mako, grim/slurp, SwayOSD, Nord theme

**Dev:** Neovim, VS Code, Node.js, .NET SDK 10, GitHub CLI

## Structure

- **system/** — drivers, services, desktop, audio, networking
- **home/** — packages, dotfiles, Hyprland config, bash aliases, cheatsheets

## Usage

```bash
nix-rebuild          # rebuild system
nix-update           # update flake inputs
nix-config           # edit config in neovim
nix-clean            # garbage collect old generations
cheat-linux          # linux cheatsheet
cheat-hyper          # hyprland cheatsheet
```
