{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with pkgs;
{
  home.username = "matheus";
  home.homeDirectory = "/home/matheus";

  home.packages = with pkgs; [
    htop
    fastfetch

    # GTK/xfwm4 themes
    arc-theme
    orchis-theme
    colloid-gtk-theme

    # icon themes
    papirus-icon-theme
    tela-icon-theme
    colloid-icon-theme
  ];

  home.stateVersion = "22.11";

  imports = [
    ../zsh/zsh.nix
    ./xfce-keybindings.nix
    # ./waybar/default.nix
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "matheus-hrm";
      email = "rodriguesm673@gmail.com";
    };
  };
  programs.home-manager.enable = true;
}
