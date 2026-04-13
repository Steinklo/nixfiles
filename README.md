# nixfiles

NixOS configuration for my desktop, managed with [flakes](https://wiki.nixos.org/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

## Structure

```
.
├── flake.nix                       # Entrypoint — inputs and system config
├── flake.lock                      # Pinned dependency versions
├── home/
│   ├── home.nix                    # User packages, programs, dotfiles
│   └── hyprland.nix                # Hyprland window manager config
└── system/
    ├── configuration.nix           # System-level config (drivers, services)
    └── hardware-configuration.nix  # Auto-generated hardware config
```

- **system/** — everything that needs root: Hyprland, NVIDIA drivers, keyd, audio, networking, login manager
- **home/** — user-level packages and dotfiles: dev tools, apps, terminal, git, Hyprland keybinds

## Software

| Category           | Choice                                              |
| ------------------ | --------------------------------------------------- |
| **Window Manager** | [Hyprland](https://hyprland.org/) (Wayland, tiling) |
| **Login Manager**  | greetd + tuigreet                                   |
| **Terminal**        | Kitty (Nord theme, JetBrains Mono Nerd Font)        |
| **Shell**          | Bash                                                |
| **Launcher**       | wofi                                                |
| **Notifications**  | mako                                                |
| **Audio**          | PipeWire (+ ALSA, PulseAudio compat)                |
| **OSD**            | SwayOSD (volume/brightness)                         |
| **Screenshots**    | grim + slurp + wl-clipboard                         |
| **Editor**         | Neovim / VS Code                                    |
| **Browser**        | Firefox                                             |
| **Gaming**         | Steam, Lutris                                       |
| **Dev**            | Node.js, .NET SDK 10, GitHub CLI                    |

## Keybindings

Hyprland keybindings use `Super` as the mod key:

| Bind               | Action                     |
| ------------------- | -------------------------- |
| `Super + Return`    | Open terminal              |
| `Super + D`         | App launcher (wofi)        |
| `Super + Q`         | Kill window                |
| `Super + H/J/K/L`  | Focus left/down/up/right   |
| `Super + 1-5`      | Switch workspace           |
| `Super + Shift+1-5` | Move window to workspace   |
| `Super + V`         | Toggle floating            |
| `Super + F`         | Fullscreen                 |
| `Super + Shift+S`   | Screenshot selection       |

## Usage

Rebuild after making changes:

```bash
sudo nixos-rebuild switch --flake .#steinklo
```

Update inputs (nixpkgs, home-manager):

```bash
nix flake update
sudo nixos-rebuild switch --flake .#steinklo
```
