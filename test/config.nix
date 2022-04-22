{ config, lib, pkgs, ... }: {

  imports = [ ../default.nix ];

  # configure admin ssh keys
  users.admins.palo.publicKey = "${lib.fileContents ./sshkey.pub}";

  # configure provisioning private Key to be used when running provisioning on the machines
  provisioner.privateKeyFile = toString ./sshkey;

  openstack = {
    enable = true;
    provider = {
      authUrl = "";
      credId = "";
      credSecret = "";
      region = "";
    };
    
    server = {
      "test" = {
        enable = true;
        name = "test";
        image = "Ubuntu 20.04 - GARR";
        flavor = "m2.medium";
        networkId = "";
        securityGroups = [""];
      };
    };
  };
}
