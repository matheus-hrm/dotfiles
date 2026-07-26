{ ... }:
{
  xfconf.settings = {
    xfce4-keyboard-shortcuts = {
      "commands/custom/<Super>Return" = "kitty";
      "commands/custom/<Super>d" = "xfce4-appfinder";
      "commands/custom/<Super>g" = "xflock4";
      "commands/custom/<Super><Shift>s" = "xfce4-screenshooter -r";
      "commands/custom/<Super><Shift>f" = "xfce4-screenshooter -f";
      "commands/custom/<Super><Shift>e" = "xfce4-session-logout";
      "commands/custom/XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_SINK@ 5%+";
      "commands/custom/XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_SINK@ 5%-";
      "commands/custom/XF86AudioMute" = "wpctl set-mute @DEFAULT_SINK@ toggle";
      "commands/custom/XF86AudioMicMute" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
      "commands/custom/XF86MonBrightnessUp" = "brightnessctl set 25%+";
      "commands/custom/XF86MonBrightnessDown" = "brightnessctl set 25%-";
      "commands/custom/XF86AudioPlay" = "playerctl play-pause";
      "commands/custom/XF86AudioNext" = "playerctl next";
      "commands/custom/XF86AudioPrev" = "playerctl previous";
    };
    xfwm4 = {
      "general/close_window_key" = "<Super><Shift>q";
      "general/fullscreen_key" = "<Super>f";
      "general/workspace_1_key" = "<Super>1";
      "general/workspace_2_key" = "<Super>2";
      "general/workspace_3_key" = "<Super>3";
      "general/workspace_4_key" = "<Super>4";
      "general/move_window_workspace_1_key" = "<Super><Shift>1";
      "general/move_window_workspace_2_key" = "<Super><Shift>2";
      "general/move_window_workspace_3_key" = "<Super><Shift>3";
      "general/move_window_workspace_4_key" = "<Super><Shift>4";
    };
  };
}
