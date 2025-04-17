{ config, pkgs, unstable, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      # ./hyperland.nix
      # ./plasma6.nix
      # ./i3wm.nix
      # ./sway.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  swapDevices = [{ device = "/swapfile"; size = 8192; }];
  system.stateVersion = "24.05";
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
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
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
    pulseaudio.enable = false;
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
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "DroidSansMono" "JetBrainsMono" ]; })
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
    gnome.nautilus
    gnomeExtensions.blur-my-shell
    git-credential-manager
    libreoffice
    nwg-look
    neovim
    obs-studio
    postman
    spotify
    spicetify-cli
    stremio
    ungoogled-chromium
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
    clang
    libclang
    python3
    go
    nodejs_22
    jdk
    bun
    elixir_1_15
    # unstable pkgs 
    unstable.discord
    unstable.ghostty
    unstable.vscode-fhs
    unstable.zed-editor
    unstable.kitty
    unstable.brave
    unstable.proton-pass
    unstable.slack
  ];

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
