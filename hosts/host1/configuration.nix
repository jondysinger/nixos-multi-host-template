/* File:        hosts/host1/configuration.nix
   Description: Host-specific configuration for host1
*/

{ ... }: {
  networking.hostName = "host1"; # Change to your hostname
  system.stateVersion = "25.11";

  ### Host-specific configuration ###

  # Examples:
  #
  #    hardware.bluetooth.enable = true; # Enable Bluetooth
  #    services.blueman.enable = true;   # Enable Blueman

  # Intel graphics
  #
  #    hardware.graphics = {
  #      enable = true;
  #      extraPackages = with pkgs; [ intel-media-driver ];
  #    };
}
