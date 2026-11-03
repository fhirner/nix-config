{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
    ./skhd.nix
  ];

  home = {
    packages = with pkgs; [
      curl
      coreutils
      uv
      zellij
      podman-compose
      gh
      k9s
    ];

    shellAliases = {
      "..." = "cd ../..";
    };
  };

  programs = {
    helix.enable = true;
    home-manager.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
      };
    };
    mise = {
      enable = true;
      enableFishIntegration = true;
      globalConfig.settings = {
        experimental = true;
        activate_shims = false;
      };
    };
  };

  services.podman = {
    enable = true;
  };
}
