{ ... }:
{
  programs.fish = {
    enable = true;

    preferAbbrs = true;
    shellAbbrs = {
      l = "less";
      g = "git";
      gco = "git checkout";
      "-C" = {
        position = "anywhere";
        expansion = "--color";
      };
    };

    functions = {
      new-ghostty = ''
        osascript -e '
          tell application "Ghostty"
            if it is running then
              activate
              tell application "System Events" to keystroke "n" using {command down}
            else
              activate
            end if
          end tell'
      '';
    };
  };
}
