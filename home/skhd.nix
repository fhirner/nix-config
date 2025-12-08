{ pkgs, ... }:
{
  services.skhd = {
    enable = true;

    config = ''
      # change size of window
      shift + lalt - w : yabai -m window --resize top:0:-50 ; yabai -m window --resize bottom:0:-50
      shift + lalt - a : yabai -m window --resize left:-50:0 ; yabai -m window --resize right:-50:0
      shift + lalt - s : yabai -m window --resize bottom:0:50 ; yabai -m window --resize top:0:50
      shift + lalt - d : yabai -m window --resize right:50:0 ; yabai -m window --resize left:100:0

      # focus window
      lalt - h : yabai -m window --focus west
      lalt - j : yabai -m window --focus south
      lalt - k : yabai -m window --focus north
      lalt - l : yabai -m window --focus east

      # balance size of windows
      shift + alt - 0 : yabai -m space --balance

      # make floating window fill screen
      shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

      # make floating window fill right-half of screen
      shift + alt - right  : yabai -m window --grid 1:2:1:0:1:1

      # fast focus desktop
      ctrl - down : yabai -m space --focus recent
      ctrl - left : yabai -m space --focus prev
      ctrl - right : yabai -m space --focus next
      ctrl - 1 : yabai -m space --focus 1
      ctrl - 2 : yabai -m space --focus 2
      ctrl - 3 : yabai -m space --focus 3
      ctrl - 4 : yabai -m space --focus 4
      ctrl - 5 : yabai -m space --focus 5
      ctrl - 6 : yabai -m space --focus 6
      ctrl - 7 : yabai -m space --focus 7
      ctrl - 8 : yabai -m space --focus 8
      ctrl - 9 : yabai -m space --focus 9
      ctrl - 0 : yabai -m space --focus 10

      # send window to desktop and follow focus
      #ctrl + shift - x : yabai -m window --space recent; yabai -m space --focus recent
      #ctrl + shift - y : yabai -m window --space prev; yabai -m space --focus prev
      #ctrl + shift - c : yabai -m window --space next; yabai -m space --focus next
      ctrl + shift - 1 : yabai -m window --space  1; yabai -m space --focus 1
      ctrl + shift - 2 : yabai -m window --space  2; yabai -m space --focus 2
      ctrl + shift - 3 : yabai -m window --space  3; yabai -m space --focus 3
      ctrl + shift - 4 : yabai -m window --space  4; yabai -m space --focus 4
      ctrl + shift - 5 : yabai -m window --space  5; yabai -m space --focus 5
      ctrl + shift - 6 : yabai -m window --space  6; yabai -m space --focus 6
      ctrl + shift - 7 : yabai -m window --space  7; yabai -m space --focus 7
      ctrl + shift - 8 : yabai -m window --space  8; yabai -m space --focus 8
      ctrl + shift - 9 : yabai -m window --space  9; yabai -m space --focus 9
      ctrl + shift - 0 : yabai -m window --space 10; yabai -m space --focus 10

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # toggle window fullscreen zoom
      #alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window native fullscreen
      shift + alt - f : yabai -m window --toggle native-fullscreen

      # toggle window split type
      #alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      #alt - t : yabai -m window --toggle float;\
      #          yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky
      #alt - s : yabai -m window --toggle sticky

      # toggle sticky, float and resize to picture-in-picture size
      #alt - p : yabai -m window --toggle sticky;\
      #          yabai -m window --grid 5:5:4:0:1:1

      alt - return : /Users/fh/bin/iterm
    '';
  };

  home.activation = {
    skhd-reloader = ''
      run ${pkgs.skhd}/bin/skhd -r
    '';
  };
}
