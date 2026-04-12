{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Skjermer: DP-2 (1440p) venstre/primær, HDMI-A-2 (1080p) høyre
      monitor = [
        "DP-2, 2560x1440@59.95, 0x0, 1"
        "HDMI-A-2, 1920x1080@60, 2560x0, 1"
      ];

      # Workspace 1 på primærskjerm (venstre)
      workspace = [
        "1, monitor:DP-2, default:true"
        "2, monitor:HDMI-A-2, default:true"
      ];

      # Oppstart
      exec-once = [
        "mako"
        "swayosd-server"
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

        # Bytt workspace
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Flytt vindu til workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Screenshot
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
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
    };
  };
}
