{ config, pkgs, hyprfence, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland.plugins = [
    hyprfence.packages.x86_64-linux.default
  ];
  home.username = "steinklo";
  home.homeDirectory = "/home/steinklo";

  home.packages = with pkgs; [
    # Utvikling
    nodejs
    dotnet-sdk_10
    azure-cli
    terraform
    gh
    neovim
    ripgrep
    vscode

    # Generellt
    unzip
    keymapp
    # Apps
    discord
    lutris

    # Hyprland-verktøy
    wofi
    mako
    grim
    slurp
    wl-clipboard
    wtype
    swayosd

    # Fonts
    nerd-fonts.jetbrains-mono
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    themeFile = "Nord";
    settings = {
      # Utseende
      background_opacity = "0.9";
      window_padding_width = 8;

      # Tabs
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    keybindings = {
      # Tab-navigasjon
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+l" = "next_tab";

      # Lukk vindu
      "ctrl+shift+q" = "close_window";
    };
  };

  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  home.file."cheatsheet-linux.md".source = ./cheatsheet-linux.md;
  home.file."cheatsheet-hyprland.md".source = ./cheatsheet-hyprland.md;
  home.file."cheatsheet-kitty.md".source = ./cheatsheet-kitty.md;

  programs.bash = {
    enable = true;
    shellAliases = {
      # NixOS
      nix-rebuild = "sudo nixos-rebuild switch --flake ~/nixfiles#steinklo";
      nix-config = "nvim ~/nixfiles";
      nix-update = "nix flake update --flake ~/nixfiles";
      nix-clean = "sudo nix-collect-garbage -d";

      # System
      sys-logout = "loginctl terminate-user steinklo";

      # Cheatsheets
      cheat-linux = "cat ~/cheatsheet-linux.md";
      cheat-hyper = "cat ~/cheatsheet-hyprland.md";
      cheat-kitty = "cat ~/cheatsheet-kitty.md";
    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "David Haland";
    settings.user.email = "david.f.haland@gmail.com";
  };

  home.stateVersion = "25.11";
}
