{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    yofi
    rofi-wayland
    gtklock
    nemo-with-extensions
    wob
    i3status
    waybar
    networkmanagerapplet
    swaylock-effects
    swayidle
    pavucontrol
    imv
  ];
  # services.xserver.displayManager.lightdm.enable = true;
  services.getty.autologinUser = "matheus";
  security.polkit.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
  services.gnome.gnome-keyring.enable = true;
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
  #     };
  #   };
  # };
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
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
  programs.regreet.enable = true;
}
