/* File:        hosts/host3/configuration.nix
   Description: Host-specific configuration for host3
*/

{ ... }: {
  networking.hostName = "host3"; # Change to your hostname

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
