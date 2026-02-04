{ pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./sway.nix
    ];

  system.stateVersion = "25.05";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  swapDevices = [{ device = "/swapfile"; size = 8192; }];

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
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    pulseaudio.enable = false;
    printing.enable = true;
    openssh.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
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

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    chromium = {
      extraOpts = ''
        --enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform --ozone-platform=wayland
      '';
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts.packages = with pkgs; [
    comic-mono
    fira-code
    hermit
    iosevka
    iosevka-comfy.comfy
    jetbrains-mono
    monocraft
    mononoki
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    roboto-mono
  ];

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    # cli
    bat
    btop
    curl
    fzf
    git
    mpv
    openvpn
    playerctl
    postgresql
    ripgrep
    tldr
    tmux
    unzip
    vim
    wget
    wl-clipboard
    # tools
    anki
    dbeaver-bin
    discord
    git-credential-manager
    gnome-calculator
    gnomeExtensions.blur-my-shell
    imv
    insomnia
    libreoffice
    nautilus
    neovim
    nwg-look
    obs-studio
    postman
    qbittorrent
    spotify
    stremio
    vesktop
    zathura
    # languages/lsp
    bun
    cargo
    clang
    clang-tools
    cmake
    gcc
    glfw
    go
    jdk
    kubectl
    kubernetes-helm
    libclang
    llvm
    minikube
    nil
    nodejs_22
    python3
    raylib
    rust-analyzer
    rustc
    rustup
    # unstablepkgs 
    pkgs.unstable.ghostty
    pkgs.unstable.vscode-fhs
    pkgs.unstable.zed-editor
    pkgs.unstable.kitty
    pkgs.unstable.brave
    pkgs.unstable.proton-pass
    (pkgs.unstable.google-chrome.override {
      commandLineArgs = [ "--enable-features=TouchpadOverscrollHistoryNavigation" ];
    })
  ];
}
