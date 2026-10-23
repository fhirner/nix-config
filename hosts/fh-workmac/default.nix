{
  inputs,
  vars,
  ...
}:
{
  home-manager.users.${vars.user}.imports = [ ./home.nix ];

  nix-homebrew.taps."gardener/homebrew-tap" = inputs.homebrew-gardener;

  homebrew = {
    brews = [
      "gardener/tap/gardenctl-v2"
      "gardener/tap/gardenlogin"
      "kubelogin"
    ];

    casks = [
      "secretive"
    ];
  };
}
