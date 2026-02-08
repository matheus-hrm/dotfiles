{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    gtklock
    i3status
    imv
    mako
    nemo-with-extensions
    networkmanagerapplet
    pavucontrol
    rofi
    slurp
    swayidle
    swaylock-effects
    tuigreet
    waybar
    wl-clipboard
    wob
    yofi
  ];
  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services = {
    getty.autologinUser = "matheus";
    gnome.gnome-keyring.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --cmd sway \
            --theme 'container=black;text=cyan;time=green;border=green;prompt=cyan;input=cyan;action=cyan;button=green' \
            --user-menu \
            --asterisks \
          '';
          user = "matheus";
        };
      };
    };
  };
  programs = {
    light.enable = true;
    sway = {
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
  };
}
