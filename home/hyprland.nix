{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Skjermer: DP-2 (1440p) primær, HDMI-A-2 (1080p) til høyre
      monitor = [
        "DP-2, 2560x1440@59.95, 0x0, 1"
        "HDMI-A-2, 1920x1080@60, 2560x0, 1"
      ];

      # Workspaces: 1-5 på primær (DP-2), 6-10 på sekundær (HDMI-A-2)
      workspace = [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:HDMI-A-2, default:true"
        "7, monitor:HDMI-A-2"
        "8, monitor:HDMI-A-2"
        "9, monitor:HDMI-A-2"
        "10, monitor:HDMI-A-2"
      ];

      # Oppstart
      exec-once = [
        "mako"
        "swayosd-server"
        "waybar"
        "firefox"
        "discord"
        "steam"
      ];

      # Variabler
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";

      # Generelle innstillinger
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(4c566aff)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };

      # Tastatursnarveier
      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, D, exec, $menu"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"

        # Flytt fokus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Bytt workspace (1-5 primær, 6-10 sekundær)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Flytt vindu til workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshot
        "$mod SHIFT, S, exec, mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy"

        # Toggle hyprfence (cursor confinement)
        "$mod, G, exec, hyprctl dispatch hyprfence:toggle"

        # Norske bokstaver (via wtype)
        ", XF86Launch8, exec, wtype ø"
        ", XF86Launch9, exec, wtype å"
        ", F19, exec, wtype æ"
        "SHIFT, XF86Launch8, exec, wtype Ø"
        "SHIFT, XF86Launch9, exec, wtype Å"
        "SHIFT, F19, exec, wtype Æ"
      ];

      # Volum
      bindl = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ];

      # Mus
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrule = [
        "match:class firefox, workspace 6 silent"
        "match:class discord, workspace 7 silent"
        "match:class steam, workspace 8 silent"
      ];

      plugin = {
        hyprfence = {
          enabled = 0;
        };
      };
    };
  };
}
