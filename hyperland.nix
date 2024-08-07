{ config, pkgs, inputs, ... }:

{
   programs.hyprland = {
     enable = true;
     # package = inputs.hyperland.packages."${pkgs.system}".hyprland;
     xwayland.enable = true;
   };

   xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   };

   services.xserver.displayManager.lightdm.enable = false;
   services.xserver.displayManager.gdm.enable = false;
   services.xserver.displayManager.sddm.enable = false;

   # Configurar autologin
   services.getty.autologinUser = "matheus";
   
   environment = {
     sessionVariables = {
       NIXOS_OZONE_WL = "1";
     };
     systemPackages = with pkgs; [
       waybar
       (waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	 })
       )
       mako
       libnotify
       swww
       dolphin
       wezterm
       rofi-wayland
       hyprpaper
       hyprlock
       hypridle
       hyprpicker
     ];
   };
   environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       exec hyprland
    fi
   '';
}
