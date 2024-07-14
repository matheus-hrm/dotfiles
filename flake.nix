{
  description = "My Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = { 
      url = "github:nix-community/home-manager/release-24.05";      
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...  }:
  let
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
    	nixos = nixpkgs.lib.nixosSystem {
	  inherit system;
	  modules = [
	    ./configuration.nix
	    #./plasma6.nix
	    ./hyperland.nix
	    home-manager.nixosModules.home-manager
	    {
	      home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;
		users.matheus = import ./home-manager/home.nix;
	      };
	    }
	  ];
	};
     };
     homeConfigurations = {
     	matheus = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [
	    ./home-manager/home.nix
	    ./zsh/zsh.nix
	  ];
	};
     };
  };
}
