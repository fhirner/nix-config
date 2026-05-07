{ ... }:
{
  services.yabai = {
    enable = true;

    config = {
      focus_follows_mouse = "autofocus";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_topmost = "off";
      window_opacity = "off";
      window_shadow = "float";
      auto_balance = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
    };
    extraConfig = ''
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^SteerMouse$" manage=off
      yabai -m rule --add title="^Preferences$" manage=off
      yabai -m rule --add app="^FaceTime$" manage=off
      yabai -m rule --add app="Stickies" manage=off
      yabai -m rule --add app="^Cryptomator$" manage=off
      yabai -m signal --add event=window_created action="yabai -m query --windows --window $YABAI_WINDOW_ID | jq -e '.\"can-resize\"' || yabai -m window $YABAI_WINDOW_ID --toggle float"
    '';
  };
}
