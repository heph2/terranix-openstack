{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {

  buildInputs = with pkgs; [
    pkgs.terranix

    (pkgs.writeShellScriptBin "terraform" ''
      export TF_VAR_openstack_api_token=`${pkgs.pass}bin/pass Root/IT/`
      ${pkgs.terraform}/bin/terraform "$@"
    '')
  ];
}
