{ config, ... }:
{
  homebrew = {
    enable = true;
    global.autoUpdate = false;

    onActivation = {
      cleanup = "uninstall";
      autoUpdate = false;
      upgrade = false;
    };

    taps = builtins.attrNames config.nix-homebrew.taps;

    masApps = {
      "amorphous-disk-mark" = 1168254295;

      "1password-safari" = 1569813296;
      "ubo-lite-safari" = 6745342698;
    };

    casks = [
      "1password-cli"
      "1password"
      "eurkey"
      "firefox"
      "ghostty"
      "kitty"
      "raycast"
      "visual-studio-code"
    ];
  };
}
