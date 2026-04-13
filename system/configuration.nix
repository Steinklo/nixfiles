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
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd start-hyprland";
      user = "greeter";
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

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

  # SwayOSD
  services.udev.packages = [ pkgs.swayosd ];
  services.dbus.packages = [ pkgs.swayosd ];
  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput Backend";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };

  # Printing
  services.printing.enable = true;

  # Users
  users.users.steinklo = {
    isNormalUser = true;
    description = "David Haland";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" ];
  };

  # System-wide packages (bare ting som trenger root/system-tilgang)
  programs.firefox.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    git
    kitty
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
            "f17" = "ø";
            "f18" = "å";
            "f19" = "æ";
          };
        };
      };
    };
  };

  # Docker
  virtualisation.docker.enable = true;

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
