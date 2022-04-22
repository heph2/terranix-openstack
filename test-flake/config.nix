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
      credentialId = "";
      credentialSecret = "";
      region = "garr-pa1";
    };
    server = {
      "test" = {
        enable = true;
        name = "test";
        image = "ubuntu-18.04";
        flavor = "m2.medium";      
      };
    };
    network.port = {
      "test" = {
        enable = true;
        name = "test";
        sec_group_id = [ "foo" ];
        net_id = "bar";
        subnet = [
          {
            subnet_id = "garr";
          }
        ];
      };
    };
  };
}
