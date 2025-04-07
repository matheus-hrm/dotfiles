{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "0lbn29dn647kgf3g3nzch8an3m0gn2ysrmq8l7q6lzc8lgwgif8p";
    };

  unstable = import unstableTarball {
    config = config.nixpkgs.config;
    system = "x86_64-linux";
  };
in
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

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

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

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.matheus = {
    isNormalUser = true;
    description = "matheus";
    extraGroups = [ "video" "networkmanager" "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  programs.zsh.enable = true;
  programs.firefox.enable = true;

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

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    neovim
    discord
    vesktop
    unstable.ghostty
    tmux
    spotify
    spicetify-cli
    unstable.vscode-fhs
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
    fzf
    ripgrep
    qbittorrent
    python3
    go
    nodejs_22
    jdk
    ungoogled-chromium
    bun
    elixir_1_15
    unstable.zed-editor
    unstable.kitty
    unzip
    gnome.nautilus
    gnomeExtensions.blur-my-shell
    brave
    nwg-look
    dbeaver-bin
    mpv
    bat
    postman
    insomnia
    postgresql
    wl-clipboard
    playerctl
    git-credential-manager
    github-desktop
    stremio
    btop
    obs-studio
    tldr
    openvpn
  ];

  environment.shells = with pkgs; [ zsh ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
