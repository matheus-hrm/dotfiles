{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.11";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "vboxdrv"
    "vboxnetadp"
    "vboxnetflt"
  ];
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];

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
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  hardware = {
    bluetooth.enable = true;
  };

  security.rtkit.enable = true;

  users = {
    users.matheus = {
      isNormalUser = true;
      description = "matheus";
      extraGroups = [
        "video"
        "networkmanager"
        "wheel"
        "docker"
      ];
      shell = pkgs.zsh;
    };
    extraGroups = {
      vboxusers.members = [ "matheus" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      comic-mono
      fira-code
      hermit
      iosevka
      iosevka-comfy.comfy
      ipaexfont
      jetbrains-mono
      monocraft
      mononoki
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      roboto-mono
    ];
  };

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
    obsidian
    postman
    qbittorrent
    spotify
    stremio-linux-shell
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
    jdt-language-server
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
  ];
}
