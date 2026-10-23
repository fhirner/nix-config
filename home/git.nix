{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      alias = {
        st = "status -sb";
      };
      user = {
        name = "Felix Hirner";
        # no global email: repos outside the folders below refuse to commit
        useConfigOnly = true;
      };
      init = {
        defaultBranch = "main";
      };
    };

    # host-specific includes are added in hosts/<hostname>/home.nix
    includes = [
      {
        condition = "gitdir:~/code/private/";
        contents.user.email = "git@futix.eu";
      }
      {
        condition = "gitdir:~/.config/";
        contents.user.email = "git@futix.eu";
      }
    ];

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4cHUF5lfD9uEjt/TzN/BwSSQwgTEShqOsy427C8TPx";
      format = "ssh";
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };

    ignores = [ ".DS_Store" ];
  };
}
