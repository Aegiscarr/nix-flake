{
  description = "various system flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixgl.url = "github:nix-community/nixGL";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    nixvim.url = "github:nix-community/nixvim";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-xr, home-manager, ...}:{
    nixosConfigurations."JIKOUJI" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./base/JIKOUJI
        home-manager.nixosModules.home-manager {
          #imports = [ inputs.nix-index-database.hmModules.nix-index ];
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
            vars = {
              isNixOS = true;
              isTough = false;
              class = "laptop";
              user = "aegiscarr"; #cursed way of setting username
            };
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aegiscarr = ./home;
        }
      ];
    };
    nixosConfigurations."SERRATA" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./base/SERRATA
        home-manager.nixosModules.home-manager {
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = {
            inherit inputs;
            vars = {
              isNixOS = true;
              isTough = false;
              class = "desktop:";
              user = "aegiscarr";
            };
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aegiscarr = ./home;
        }
      ];
    };    
    #other confs go here, cant be assed rn
    homeConfigurations.generic = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [inputs.nixgl.overlay]; };
      modules = [ ./home ];
      extraSpecialArgs = { 
        inherit inputs; 
        vars = {
          isNixOS = false;
          class = "laptop";
          user = "aegiscarr";
        };
      };
    };
  };
}
