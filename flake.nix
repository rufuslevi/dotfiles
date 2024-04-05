{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , anyrun
    , darwin
    , nixpkgs
    , nixpkgs-darwin
    , home-manager
    , nix-homebrew
    , ...
    }@inputs:
    let
      user = "rufuslevi";
      system = "aarch64-darwin";
      specialArgs = { inherit user nixpkgsDarwinConfig; };

      inherit (inputs.nixpkgs-unstable.lib)
        attrValues makeOverridable optionalAttrs singleton;

      nixpkgsDarwinConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev:
            (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
              inherit (final.pkgs-x86) idris2 nix-index niv purescript;
            })
        );
      };
    in
    {
      overlays = {
        comma = final: prev: {
          comma = import inputs.comma { inherit (prev) pkgs; };
        };
        apple-silicon = final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            pkgs-x86 = import inputs.nixpkgs-darwin {
              system = "86_64-darwin";
              inherit (nixpkgsDarwinConfig) config;
            };
          };
      };

      darwinConfigurations = rec {
        luna = darwin.lib.darwinSystem {
          inherit system specialArgs;
          modules = [
            { nixpkgs = nixpkgsDarwinConfig; }
            home-manager.darwinModules.home-manager
            ./nix/darwin/configuration.nix
          ];
        };
      };

      nixosConfigurations.domum-light = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rufuslevi = {
                imports = [
                  ./nix/nixos/domum/home/home.nix
                  ./nix/nixos/shared/home/light_theme.nix
                  anyrun.homeManagerModules.anyrun
                ];
              };
            };
          }
          ./nix/nixos/domum/configuration.nix
        ];
      };

      nixosConfigurations.domum-dark = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.rufuslevi = {
                imports = [
                  ./nix/nixos/domum/home/home.nix
                  ./nix/nixos/shared/home/dark_theme.nix
                  anyrun.homeManagerModules.anyrun
                ];
              };
            };
          }
          ./nix/nixos/domum/configuration.nix
        ];
      };

      nixosConfigurations.milkyway = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./nix/nixos/milkyway/configuration.nix
        ];
      };
    };
}
