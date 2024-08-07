{ config, pkgs, lib, ...}:

{
  services = {
    picom = {
      enable = true;
    };
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager.defaultSession = "xfce+i3";
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
          i3-gaps
          polybar
          lxappearance
          nitrogen
          clipmenu
        ];
      };
    };
  }; 
}
