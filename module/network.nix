{ config, lib, pkgs, ... }:
with lib;
with types;

let
  cfg = config.openstack.network;
in
{
  options.openstack.network = {
    port = {
      name = mkOption {
        type = str;
        description = ''
          A unique name for the port.
        '';           
      };
      networkId = mkOption {
        type = str;
        description = ''
          The ID of the network to attach the port to.
        '';         
      };
      securityGroups = mkOption {
        type = listOf str;
        description = ''
          A list of security group IDs to apply to the port.
        '';   
      };
    };
    fip = {
      pool = mkOption {
        type = str;
        description = ''
          The name of the pool from which to obtain the
          floating IP.
        '';
      };
    };
  };
  
  config = mkIf (cfg != { }) {
    resource.openstack_networking_port_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.port.name}";
            value = {
              name = configuration.port.name;
              network_id = configuration.port.networkId;
              security_group_ids = configuration.port.securityGroups;
            };
          })
          cfg;
      in
        allResources;
    resource.openstack_networking_floatingip_v2 =
      let
        allResources = mapAttrs'
          (name: configuration: {
            name = "${configuration.port.name}-fip";
            value = {
              pool = configuration.fip.pool;
            };
          })
          cfg;
      in
        allResources;
    resource.openstack_compute_floatingip_associate_v2 =
      let
        fipPart = name: ''
          floating_ip = "''${ openstack_networking_floatingip_v2.${configuration.port-name}-fip.address}";
          instance_id = "''${ openstack_compute_instance_v2.${name}.id";
          '';
        allFipParts = map fipPart (attrNames config.openstack.server);
      in
        ''
        {
        ${concatStringsSep "\n" allFipParts}
        }
        '';
  };
}
