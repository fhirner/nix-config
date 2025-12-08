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
  };
}
