{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      margin-top = 10;
      margin-left = 10;
      margin-right = 10;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "cpu" "memory" "disk" "network" ];
      modules-right = [ "clock" ];

      "hyprland/workspaces" = {
        format = "{name}";
        persistent-workspaces = {
          "*" = 5;
        };
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%A %d. %B %Y}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      cpu = {
        format = "  {usage}%";
        interval = 5;
      };

      memory = {
        format = "  {percentage}%";
        tooltip-format = "{used:0.1f} / {total:0.1f} GiB";
        interval = 5;
      };

      disk = {
        format = "  {percentage_used}%";
        tooltip-format = "{used} / {total}";
        path = "/";
        interval = 30;
      };

      network = {
        format-ethernet = "  {bandwidthTotalBytes}";
        format-disconnected = "  Frakoblet";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        interval = 5;
      };
    }];

    style = ''
      /* Nord-farger */
      @define-color nord0  #2e3440;
      @define-color nord1  #3b4252;
      @define-color nord2  #434c5e;
      @define-color nord3  #4c566a;
      @define-color nord4  #d8dee9;
      @define-color nord8  #88c0d0;
      @define-color nord9  #81a1c1;
      @define-color nord10 #5e81ac;
      @define-color nord11 #bf616a;
      @define-color nord13 #ebcb8b;
      @define-color nord14 #a3be8c;

      * {
        font-family: "JetBrainsMono NF", "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(46, 52, 64, 0.9);
        border-radius: 8px;
        border: 1px solid @nord3;
        color: @nord4;
      }

      /* Felles modul-stil */
      #workspaces,
      #clock,
      #cpu,
      #memory,
      #disk,
      #network {
        padding: 4px 16px;
        margin: 4px 0;
        border-radius: 0;
        background: transparent;
        border: none;
      }

      /* Workspaces */
      #workspaces {
        padding: 4px 8px;
      }

      #workspaces button {
        color: @nord3;
        padding: 0 10px;
        margin: 0 3px;
        border: none;
        border-radius: 3px;
        background: transparent;
        font-size: 12px;
      }

      #workspaces button.active {
        color: @nord0;
        background: @nord8;
      }

      #workspaces button.empty {
        color: @nord3;
      }

      #workspaces button:hover {
        background: @nord2;
        color: @nord4;
      }

      /* Klokke */
      #clock {
        color: @nord8;
        font-weight: bold;
      }

      /* System-moduler med separatorer */
      #cpu,
      #memory,
      #disk {
        border-right: 1px solid @nord3;
      }

      #cpu {
        color: @nord9;
      }

      #memory {
        color: @nord13;
      }

      #disk {
        color: @nord14;
      }

      #network {
        color: @nord8;
      }

      #network.disconnected {
        color: @nord11;
      }
    '';
  };
}
