{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    terranix = {
      url = "github:terranix/terranix/develop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #    module-openstack.url = "path:/home/heph/env/terraform/terranix/terranix-openstack";
    module-openstack.url = "github:heph2/terranix-openstack";
  };

  outputs = { self, nixpkgs, flake-utils, terranix, module-openstack }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        terraform = pkgs.writers.writeBashBin "terraform" ''
          ${pkgs.terraform}/bin/terraform "$@"
        '';
        terranixConfiguration = terranix.lib.terranixConfiguration {
          inherit system;
          modules = [
            module-openstack.terranixModule
            ./config.nix
          ];
        };
      in
        {
          defaultPackage = terranixConfiguration;
          # nix develop
          devShell = pkgs.mkShell {
            buildInputs =
              [ terraform terranix.defaultPackage.${system} ];
          };

          # nix run ".#prepare"
          apps.prepare = {
            type = "app";
            program = toString (pkgs.writers.writeBash "prepare" ''
              ${pkgs.openssh}/bin/ssh-keygen -P "" -f sshkey
              ${pkgs.git}/bin/git add sshkey
              ${pkgs.git}/bin/git add sshkey.pub
            '');
          };
          # nix run ".#apply"
          apps.apply = {
            type = "app";
            program = toString (pkgs.writers.writeBash "apply" ''
              if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
              cp ${terranixConfiguration} config.tf.json \
                && ${terraform}/bin/terraform init \
                && ${terraform}/bin/terraform apply
            '');
          };
          # nix run ".#destroy"
          apps.destroy = {
            type = "app";
            program = toString (pkgs.writers.writeBash "destroy" ''
              if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
              cp ${terranixConfiguration} config.tf.json \
                && ${terraform}/bin/terraform init \
                && ${terraform}/bin/terraform destroy
                && rm -f sshkey*
                '');
          };
          # nix run
          defaultApp = self.apps.${system}.apply;
        });
}
  
