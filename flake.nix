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
    fhirner-ssh = {
      url = "https://github.com/fhirner.keys";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
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
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      darwinConfigurations.${vars.hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit vars;
        };
        modules = [
          ./darwin
          (
            { pkgs, ... }:
            {
              nixpkgs = {
                config.allowUnfree = true;
                hostPlatform = "aarch64-darwin";
              };

              system = {
                stateVersion = 6;
                primaryUser = vars.user;
                configurationRevision = self.rev or self.dirtyRev or null;
              };

              users.knownUsers = [ vars.user ];
              users.users.${vars.user} = {
                name = vars.user;
                uid = 501;
                home = "/Users/${vars.user}";
                shell = pkgs.fish;
              };

              networking = {
                computerName = vars.hostname;
                hostName = vars.hostname;
                localHostName = vars.hostname;
              };

              nix = {
                settings.experimental-features = "nix-command flakes";
                nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
              };
            }
          )
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
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.${vars.user} =
                { ... }:
                {
                  imports = [ ./home ];
                  home.stateVersion = "25.05";
                };
              backupFileExtension = "backup-before-hm";
            };
          }
        ];
      };
    };
}
