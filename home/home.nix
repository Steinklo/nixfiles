{ config, pkgs, ... }:

{
  home.username = "steinklo";
  home.homeDirectory = "/home/steinklo";

  home.packages = with pkgs; [
    # Utvikling
    nodejs
    dotnet-sdk_10
    gh
    neovim
    vscode

    # Apps
    discord
    lutris
    kdePackages.kate
  ];

  programs.git = {
    enable = true;
    settings.user.name = "David Haland";
    settings.user.email = "david.f.haland@gmail.com";
  };

  home.stateVersion = "25.11";
}
