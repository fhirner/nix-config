{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    inputs@{
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      ...
    }:
    let
      vars = {
        user = "fh";
        hostname = "fh-workmac";
      };
      system = "aarch64-darwin";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      darwinConfigurations.${vars.hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit vars;
        };
        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = vars.user;

              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
              };
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${vars.user}" = import ./home.nix;
            home-manager.backupFileExtension = "backup-before-hm";
          }
        ];
      };
      my-output = 1 + 1;
      packages.${system}.default = nixpkgs.legacyPackages.${system}.ponysay;
    };
}
