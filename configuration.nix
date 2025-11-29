{
  config,
  inputs,
  pkgs,
  vars,
  ...
}:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    nixd
    nixfmt-rfc-style
    mas
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set NIX_PATH for nixd LSP support in flakes-only setup
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  system.primaryUser = vars.user;

  security.pam.services.sudo_local.touchIdAuth = true;

  networking = {
    computerName = vars.hostname;
    hostName = vars.hostname;
    localHostName = vars.hostname;
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 5.0;
      spaces.spans-displays = false;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "left";
        mru-spaces = false;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # current folder
        QuitMenuItem = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

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
      "ubo-lite-safari" = 6745342698;
      "1password-safari" = 1569813296;
    };

    casks = [
      "firefox"
      "1password"
      "1password-cli"
      "visual-studio-code"
      "eurkey"
    ];
  };

  users.knownUsers = [ vars.user ];
  users.users.${vars.user} = {
    name = vars.user;
    uid = 501;
    home = "/Users/${vars.user}";
    shell = pkgs.fish;
  };
}
