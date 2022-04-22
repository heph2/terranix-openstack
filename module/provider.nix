{ config, lib, ... }:

with lib;
with types;

let
  cfg = config.openstack;
in
{
  options.openstack = {
    enable = mkEnableOption ''
      openstack provider
      See https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs for documentation.
    '';
    provider = {
      authUrl = mkOption {
        type = str;
        default = "\${ admin }";
        description = ''
          The identity authentication URL. If omitted, the
          OS_AUTH_URL environment variable is used.
        '';
      };
      credId = mkOption {
        type = str;
        default = "\${ admin }";
        description = ''
          The ID of an application credential to authenticate with.
          A credSecret has to be set along with this parameter.
        '';        
      };
      credSecret = mkOption {
        type = str;
        default = "\${ pwd }";
        description = ''
          The secret of an application credential to authenticate
          with. Required by credId.
        '';        
      };
      region = mkOption {
        type = str;
        default = "\${ admin }";
        description = ''
          The region of the OpenStack cloud to use.
        '';        
      };
      cloud = mkOption {
        type = str;
        default = "garr-pa1";
        description = ''
          An entry in a clouds.yaml file. See the OpenStack
          documentation for more information about.
          Required if authUrl is not specified.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      provider.openstack = {
        inherit (cfg.provider) region cloud;
        authentication_url = cfg.provider.authUrl;
        application_credential_id = cfg.provider.credId;
        application_credential_secret = cfg.provider.credSecret;
      };
      terraform.required_providers.openstack.source = "terraform-provider-openstack/openstack";
    })
  ];
}
