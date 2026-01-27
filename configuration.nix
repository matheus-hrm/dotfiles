{ config, pkgs, unstable, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      # ./hyperland.nix
      # ./plasma6.nix
      # ./i3wm.nix
      ./sway.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  swapDevices = [{ device = "/swapfile"; size = 8192; }];
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";
      videoDrivers = [ "amdgpu" ];
      # desktopManager.gnome.enable = true;
      # displayManager.gdm.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    printing.enable = true;
    openssh.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  hardware = {
    bluetooth.enable = true;
  };

  security.rtkit.enable = true;

  users.users.matheus = {
    isNormalUser = true;
    description = "matheus";
    extraGroups = [ "video" "networkmanager" "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    brave.commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform --ozone-platform=wayland"
    ];
  };

  fonts.packages = with pkgs; [
    fira-code
    iosevka
    monocraft
    mononoki
    roboto-mono
    hermit
    jetbrains-mono
    comic-mono
    iosevka-comfy.comfy
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    # cli
    vim
    wget
    curl
    git
    tmux
    fzf
    ripgrep
    unzip
    postgresql
    tldr
    mpv
    bat
    wl-clipboard
    playerctl
    openvpn
    btop
    # tools
    dbeaver-bin
    insomnia
    nautilus
    gnomeExtensions.blur-my-shell
    git-credential-manager
    libreoffice
    nwg-look
    neovim
    obs-studio
    postman
    spotify
    stremio
    vesktop
    qbittorrent
    # languages/lsp
    rustc
    cargo
    rustup
    gcc
    cmake
    raylib
    glfw
    clang
    llvm
    clang-tools
    libclang
    python3
    go
    nodejs_22
    jdk
    bun
    # unstable pkgs 
    unstable.ghostty
    unstable.vscode-fhs
    unstable.zed-editor
    unstable.kitty
    unstable.brave
    unstable.proton-pass
  ];

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
