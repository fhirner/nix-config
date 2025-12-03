{ inputs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Felix Hirner";
        email = "mail@felix-hirner.de";
      };
    };

    signing = {
      key = builtins.readFile inputs.fhirner-ssh;
      format = "ssh";
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };

    ignores = [ ".DS_Store" ];
  };
}
