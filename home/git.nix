{ inputs, ... }:
let
  personal = {
    user.email = "git@futix.eu";
  };
in
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

    includes = [
      {
        condition = "gitdir:~/code/private/";
        contents = personal;
      }
      {
        condition = "gitdir:~/.config/";
        contents = personal;
      }
      {
        condition = "gitdir:~/code/work/";
        path = "~/.config/git/work.inc";
      }
    ];

    signing = {
      key = builtins.readFile inputs.fhirner-ssh;
      format = "ssh";
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };

    ignores = [ ".DS_Store" ];
  };
}
