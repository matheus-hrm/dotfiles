{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "matheus";
  };

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    pavucontrol
    xfce4-genmon-plugin
  ];
}
