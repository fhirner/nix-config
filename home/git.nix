{
  config,
  pkgs,
  ...
}:
let
  home = config.home.homeDirectory;
  secretiveSock = "${home}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  bwiKey = "${home}/.ssh/bwi.pub";
in
{
  home.file.".ssh/bwi.pub".text =
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNpRbTm23aLw6JYzf/xBCBXG+H1AzoTmw3H/il5/GuVOTPv5J3oSPyt5O/N5M+H7D9+Am3VAIE4FcP3Sydc34OE= felix.hirner@bwi.de\n";

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
        contents.user.email = "git@futix.eu";
      }
      {
        condition = "gitdir:~/.config/";
        contents.user.email = "git@futix.eu";
      }
      {
        condition = "gitdir:~/code/work/";
        contents = {
          user = {
            email = "felix.hirner@opendefense.cloud";
            signingKey = bwiKey;
          };
          gpg.ssh.program = "${pkgs.writeShellScript "secretive-sign" ''
            SSH_AUTH_SOCK="${secretiveSock}" exec ${pkgs.openssh}/bin/ssh-keygen "$@"
          ''}";
          core.sshCommand = "ssh -o IdentityAgent=${secretiveSock} -o IdentitiesOnly=yes -i ${bwiKey}";
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@gitlab.opencode.de:*/**";
        contents.user.email = "felix.hirner@bwi.de";
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
