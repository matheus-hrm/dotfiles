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

  services.xserver = {
    enable = true;
    xkb.layout = "br";
    videoDrivers = [ "amdgpu" ];
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.matheus = {
    isNormalUser = true;
    description = "matheus";
    extraGroups = [ "video" "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };


  programs.zsh.enable = true;
  programs.firefox.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts.packages = with pkgs; [
    fira-code
    iosevka
    monocraft
    jetbrains-mono
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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  nixpkgs.config.brave.commandLineArgs = [
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
    "--enable-features=touchpadOverscrollHistoryNavigation"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       nix build --no-link ~/nixos#homeConfigurations.matheus.activationPackage &
       "$(nix path-info ~/nixos#homeConfigurations.matheus.activationPackage)"/activate  
    fi
  '';

  virtualisation = {
    docker.enable = true;
    virtualbox.enable = true;
  };
  system.stateVersion = "24.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
