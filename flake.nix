{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: let
      username = "ncamargo";
      mac = "aarch64-darwin";
      linux = "x86_64-linux";
      useremail = "ncamargo@othostelecom.co.za";

      specialArgs = {
        inherit inputs;
        inherit username useremail;
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Nelsons-MacBook-Pro-3
    darwinConfigurations."Nelsons-MacBook-Pro-3" = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      pkgs = nixpkgs.legacyPackages.${mac};
      modules = [
        ./configuration.nix
        ./modules/darwin.nix
        home-manager.darwinModules.home-manager
        {
          #home-manager.useGlobalPkgs = false;
          #home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.${username} = import ./home;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    #darwinPackages = self.darwinConfigurations."Nelsons-MacBook-Pro-3".pkgs;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs {
          inherit linux;
          config.allowUnfree = true;
        };
        inherit inputs linux;
      };
      modules = [
        ./configuration.nix
        ./modules/linux.nix
      ];
    };

    homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${linux};
          modules = [
            ./configuration.nix
            ./modules/linux.nix
          ];
        };
    };
  };
}
