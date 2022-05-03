{ config, lib, pkgs, ... }:
with lib;
with types;
let
  cfg = config.openstack.server;
  allAdmins =
    if (hasAttr "admins" config.users)
    then config.users.admins
    else { };
in
{
  options.openstack.server = mkOption {
    default = { };
    description = ''
      servers deployed to openstack.
    '';
    type =
      attrsOf (submodule ({ name, ... }: {
        options = {
          enable = mkEnableOption ''
            Deploy server
          '';
          name = mkOption {
            default = "${name}";
            type = str;
            description = ''
              Name of the server to deploy.
            '';
          };
          provisioners = mkOption {
            default = [ ];
            type = listOf attrs;
            description = ''
              provision steps.
              remote-exec...
            '';               
          };
          networks = mkOption {
            default = [
              {
                port = "\${openstack_networking_port_v2.test.id}";
              }
            ];
            type = listOf attrs;
            description = ''
              An array of one or more networks to attach to the instance.
            '';               
          };
          networkId = mkOption {
            type = str;
            description = ''
              A network id
            '';
          };
          floatingIpPool = mkOption {
            default = "floating-ip";
            type = str;
            description = ''
              A pool from the floating ip will be withdrawed.
            '';
          };
          image = mkOption {
            default = "ubuntu-18.04";
            type = str;
            description = ''
              image to spawn on the server
            '';
          };
          flavor = mkOption {
            default = "m2.medium";
            type = str;
            description = ''
              Flavor types.
            '';
          };
          securityGroups = mkOption {
            type = listOf str;
            description = ''
              A list of security groups ids.
            '';
          };
          extraConfig = mkOption {
            default = { };
            type = attrs;
            description = ''
              parameter of the openstack_server not covered yet.
            '';
          };
        };
      }));
  };

  config = mkIf (cfg != { }) {
    openstack.enable = true;

    resource.openstack_compute_instance_v2 =
      let
        allUsers =
          mapAttrsToList (name: ignore: "\${ openstack_compute_keypair_v2.${name}.id }")
            allAdmins;
        
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.name}";
            value = {
              name = configuration.name;
              image_name = configuration.image;
              flavor_name = configuration.flavor;
              network = configuration.networks;
          } // configuration.extraConfig;
          })
          cfg;
    in
      allResources;

    resource.openstack_networking_port_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.name}-port";
            value = {
              name = "${configuration.name}-port";
              network_id = configuration.networkId;
              security_groups_ids = configuration.securityGroups;
            };
          })
          cfg;
      in
        allResources;

    resource.openstack_networking_floatingip_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.name}-fip";
            value = {
              pool = configuration.floatingIpPool;
            };
          })
          cfg;
      in
        allResources;

    resource.openstack_compute_floatingip_associate_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.name}-fip-associate";
            value = {
              floating_ip = "\${ openstack_networking_floatingip_v2.${configuration.name}-fip.address }";
              instance_id = "\${ openstack_compute_instance_v2.${configuration.name}.id }";
            };
          })
          cfg;
      in
        allResources;

    output =
      let
        ipv4Address = mapAttrs'
          (ignore: configuration: {
            name = "${configuration.name}_ipv4_address";
            value = {
              value = "\${ openstack_compute_instance_v2.${configuration.name}.access_ip_v4 }";
            };
          })
          cfg;

        ipv6Address = mapAttrs'
          (ignore: configuration: {
            name = "${configuration.name}_ipv6_address";
            value = {
              value = "\${ openstack_compute_instance_v2.${configuration.name}.access_ip_v6 }";
            };
          })
          cfg;

      in
        ipv4Address // ipv6Address;

    resource.openstack_compute_keypair_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "server_${name}";
            value = {
              name = "SSH Key ${name}";
              public_key = configuration.publicKey;
            };
          })
          allAdmins;
      in
        allResources;
  };
}
