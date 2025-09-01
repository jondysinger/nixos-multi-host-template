/*
  File:        hosts/host3/configuration.nix
  Description: Host-specific configuration for host3
*/

{ ... }:
{
  networking.hostName = "host3"; # Change to your hostname
  system.stateVersion = "25.11";

  ### Host-specific configuration ###

  # Example: Media server / Jellyfin machine
  #
  #    services.jellyfin.enable = true;
  #
  #    hardware.graphics = {
  #      enable = true;
  #      extraPackages = with pkgs; [ intel-media-driver ];
  #    };
  #
  #    networking.firewall.allowedTCPPorts = [ 8096 ];
  #
  #    services.openssh.enable = true; # Remote administration
  #    services.smartd.enable = true;  # Disk health monitoring
}
