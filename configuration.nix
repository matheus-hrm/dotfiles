{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # ./hyperland.nix
      # ./plasma6.nix
      ./i3wm.nix
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
    xkb.layout = "us";
  };
  services.printing.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
     fira-code
     iosevka
     (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    neovim
    discord
    vesktop
    spotify
    spicetify-cli
    vscode-fhs
    rustc
    cargo
    rustup
    bend
    gcc
    python3
    go
    nodejs_22
    bun
    elixir_1_15
    zed-editor
    kitty
    unzip
    nwg-look
    dbeaver-bin
  ];
  
  environment.shells = with pkgs; [ zsh ]; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

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

  virtualisation.docker.enable = true;
  system.stateVersion = "24.05"; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
