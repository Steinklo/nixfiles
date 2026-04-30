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
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --cmd start-hyprland";
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

  # Plex Media Server
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  fileSystems."/mnt/kingston" = {
    device = "/dev/disk/by-label/KINGSTON";
    fsType = "exfat";
    options = [ "defaults" "nofail" "uid=plex" "gid=plex" ];
  };

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
    claude-code
    wowup-cf
  ];

  nixpkgs.config.allowUnfree = true;

  # keyd (tom – norske bokstaver håndteres via wtype i Hyprland)
  services.keyd.enable = false;

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
