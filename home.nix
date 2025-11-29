{ pkgs, ... }:
{
  home = {
    stateVersion = "25.05";

    packages = with pkgs; [
      curl
      ponysay
      uv
      ruff
      prek
    ];
  };

  programs = {
    fish = {
      enable = true;
    };
    home-manager.enable = true;
    helix.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
    };
  };
}
