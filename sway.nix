{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    yofi
    dunst
    rofi-wayland
    gtklock
    cinnamon.nemo-with-extensions
    wob
    i3status
    waybar
    networkmanagerapplet
  ];
  # services.xserver.displayManager.lightdm.enable = true;
  services.getty.autologinUser = "matheus";
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = false;
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
