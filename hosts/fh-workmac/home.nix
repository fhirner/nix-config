{
  config,
  lib,
  pkgs,
  ...
}:
let
  home = config.home.homeDirectory;
  secretiveSock = "${home}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  bwiKey = "${home}/.ssh/bwi.pub";
in
{
  home.packages = with pkgs; [
    maven
    grype
  ];

  home.file.".ssh/bwi.pub".text =
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNpRbTm23aLw6JYzf/xBCBXG+H1AzoTmw3H/il5/GuVOTPv5J3oSPyt5O/N5M+H7D9+Am3VAIE4FcP3Sydc34OE= felix.hirner@bwi.de\n";

  # mkAfter: keep these after the shared includes so they take precedence
  programs.git.includes = lib.mkAfter [
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
}
