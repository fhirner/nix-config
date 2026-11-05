{
  config,
  lib,
  pkgs,
  ...
}:
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
      # docker CLI compat: plain symlinks to podman (no Docker CLI). Docker API clients
      # use /var/run/docker.sock, which podman-mac-helper (Podman Desktop) links to the
      # rootless machine socket.
      (runCommand "podman-docker-compat" { } ''
        mkdir -p $out/bin
        ln -s ${lib.getExe config.services.podman.package} $out/bin/docker
        ln -s ${lib.getExe podman-compose} $out/bin/docker-compose
      '')
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
    # `docker compose` -> `podman compose` -> podman-compose; drop the per-call banner
    settings.containers.engine.compose_warning_logs = false;
  };
}
