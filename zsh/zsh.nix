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
    initContent = ''
    # Configuração do Spaceship Prompt
      SPACESHIP_PROMPT_ORDER=(
        user
        dir
        host
        git
        nix_shell     # Indicador de Nix shell
        python        # Indicador de Python/venv
        exec_time
        line_sep
        jobs
        exit_code
        char
      )

      # Nix Shell
      SPACESHIP_NIX_SHELL_SHOW=true
      SPACESHIP_NIX_SHELL_PREFIX="via "
      SPACESHIP_NIX_SHELL_SUFFIX=" "
      SPACESHIP_NIX_SHELL_SYMBOL="❄︎ "
      SPACESHIP_NIX_SHELL_COLOR="cyan"

      # Python
      SPACESHIP_PYTHON_SHOW=true
      SPACESHIP_PYTHON_PREFIX="via "
      SPACESHIP_PYTHON_SUFFIX=" "
      SPACESHIP_PYTHON_SYMBOL="🐍 "
      SPACESHIP_PYTHON_COLOR="yellow"
      SPACESHIP_PYTHON_SHOW_SYSTEM=false
      source ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh
      bindkey '^f' autosuggest-accept
      [ "$(tty)" = "/dev/tty1" ] && exec sway
    '';
  };
}
