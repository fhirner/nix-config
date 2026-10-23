{
  vars,
  ...
}:
{
  home-manager.users.${vars.user}.imports = [ ./home.nix ];

  homebrew = {
    casks = [
      "bitwarden"
      "element"
      "secretive"
    ];
  };
}
