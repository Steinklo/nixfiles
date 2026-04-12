{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "steinklo";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Hyprland
  programs.hyprland.enable = true;

  # ZSA keyboard (udev-regler for flashing)
  hardware.keyboard.zsa.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Users
  users.users.steinklo = {
    isNormalUser = true;
    description = "David Haland";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
  };

  # System-wide packages (bare ting som trenger root/system-tilgang)
  programs.firefox.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  nixpkgs.config.allowUnfree = true;

  # Norwegian keys via keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            "f17" = "æ";
            "f18" = "ø";
            "f19" = "å";
          };
        };
      };
    };
  };

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.powerManagement.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.11";
}
