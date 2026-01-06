{
  description = "epic nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      defaultUser = {
        name = "yugin";
        email = "theyugin@gmail.com";
      };
    in
    {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            stylix.nixosModules.stylix

            ./hosts/pc

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.${defaultUser.name} = import ./home/pc/users/yugin.nix;
            }
          ];
        };

        pc-wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.wsl

            ./hosts/pc-wsl

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.yugin = import ./home/pc-wsl.nix;
            }
          ];
        };
      };
      devShells = {
        "${system}" = {
          default =
            with pkgs;
            pkgs.mkShell {
              packages = [
                just
                nixfmt-rfc-style
                nixfmt-tree
              ];
            };
        };
      };
    };
}
