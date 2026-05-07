{ pkgs, ... }:
{
  imports = [
    ./homebrew.nix
    ./yabai.nix
  ];

  environment.systemPackages = with pkgs; [
    mas
    nixd
    nixfmt-rfc-style
    vim
    helm-ls
    yaml-language-server
    kubectl
    kubernetes-helm
    gopls
  ];

  programs = {
    fish.enable = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 5.0;
      spaces.spans-displays = false;

      CustomUserPreferences = {
        kCFPreferencesAnyApplication = {
          TSMLanguageIndicatorEnabled = false;
        };
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.15;
        orientation = "left";
        mru-spaces = false;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = false;
        CreateDesktop = true;
        _FXSortFoldersFirst = true;
        FXDefaultSearchScope = "SCcf"; # current folder
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        QuitMenuItem = true;
      };

      hitoolbox.AppleFnUsageType = "Do Nothing";

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleKeyboardUIMode = 2;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };
}
