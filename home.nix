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
  };
}
