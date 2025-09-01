/*
  File:        hosts/host2/configuration.nix
  Description: Host-specific configuration for host2
*/

{ ... }:
{
  networking.hostName = "host2"; # Change to your hostname
  system.stateVersion = "25.11";

  ### Host-specific configuration ###

  # Example: Gaming desktop / Steam machine
  #
  #    programs.steam = {
  #      enable = true;
  #      remotePlay.openFirewall = true;
  #      dedicatedServer.openFirewall = true;
  #    };
  #
  #    services.sunshine = {
  #      enable = true;
  #      autoStart = false;
  #      capSysAdmin = true;
  #      openFirewall = true;
  #    };
  #
  #    hardware.graphics = {
  #      enable = true;
  #      enable32Bit = true;
  #    };
  #
  #    services.xserver.videoDrivers = [ "amdgpu" ];
}
