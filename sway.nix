{ config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako 
    yofi
    rofi-wayland
    gtklock
    cinnamon.nemo-with-extensions
    wob
    i3status 
    waybar
  ];
  services.xserver.displayManager.lightdm.enable = false;
  services.getty.autologinUser = "matheus";
  xdg.portal = {
    enable = true; 
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaybg
      swayfx
      swayimg
    ];
  };
  programs.light.enable = true;
}
