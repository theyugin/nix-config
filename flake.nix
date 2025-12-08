{
  description = "yugin config";

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

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      stylix,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            stylix.nixosModules.stylix

            ./hosts/common
            ./hosts/nixos

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.yugin = import ./home/nixos.nix;
            }
          ];
        };

        pc-wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.wsl

            ./hosts/wsl

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.yugin = import ./home/wsl.nix;
            }
          ];
        };
      };
      devShells = {
        "${system}" = {
          default =
            with pkgs;
            let
              nvim = nixvim.legacyPackages.x86_64-linux.makeNixvim {
                plugins.lsp.enable = true;
                colorschemes.gruvbox.enable = true;
              };
            in
            pkgs.mkShell {
              packages = [
                nvim
                just
                nixfmt-rfc-style
                nixfmt-tree
              ];
            };
        };
      };
    };
}
