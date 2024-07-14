{ lib, config, pkgs, ... }:
with lib;
with pkgs;
{
  home.username = "matheus";
  home.homeDirectory = "/home/matheus";

  home.packages = with pkgs; [
    htop
    neofetch
  ];
 
  home.stateVersion = "22.11";
 
  imports = [
    ../zsh/zsh.nix
    # ./waybar/default.nix
  ];

  programs.git = {
    enable = true;
    userName = "matheus-hrm";
    userEmail = "rodriguesm673@gmail.com";
  };
  programs.home-manager.enable = true;
}
