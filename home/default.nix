{ pkgs, ... }:
{
  imports = [ ./git.nix ];

  home = {
    packages = with pkgs; [
      curl
      ponysay
      prek
      ruff
      uv
    ];
  };

  programs = {
    fish.enable = true;
    helix.enable = true;
    home-manager.enable = true;
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
