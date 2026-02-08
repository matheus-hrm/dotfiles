{
  description = "My Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";

      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = overlays;
            })

            ./configuration.nix
            #./plasma6.nix
            #./hyprland.nix
            #./i3wm.nix
            ./sway.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                users.matheus = import ./home-manager/home.nix;
              };
            }
          ];
        };
      };
      homeConfigurations = {
        matheus = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs
            {
              inherit system;
              config.allowUnfree = true;
              overlays = overlays;
            };
          modules = [
            ./home-manager/home.nix
            ./zsh/zsh.nix
          ];
        };
      };
    };
}     
