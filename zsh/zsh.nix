{ lib, config, pkgs, ... }:
with pkgs;
with lib;
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
       {
         name = "spaceship-prompt";
	 file = "spaceship.zsh-theme";
	 src = fetchFromGitHub {
	   owner = "spaceship-prompt";
	   repo = "spaceship-prompt";
	   rev = "df8d4ff46bb8aa83a32a8b1b119f16e6121ebdd4";
	   sha256 = "sha256-Rs5/LVIAaTzsdhqjdibnmP+5ZdprvBancR3a5xFBwiM";
	};
       }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ 
       "docker-compose" 
       "docker"
       "git"
       "sudo"
       "node"
      ];
      # theme = "spaceship-prompt";
    };
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
      hm-switch = "home-manager switch --flake ~/nixos#matheus";
      cat = "bat";
    };
    initExtra = ''
     bindkey '^f' autosuggest-accept
     [ "$(tty)" = "/dev/tty1" ] && exec sway
    ''; 
  };
}
