/* File:        modules/desktop.nix
   Description: This shared module declares settings which are related to the desktop environment and GUI apps.
*/

{ pkgs, ... }: {
  # Desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # GUI applications to install
  environment.systemPackages = with pkgs; [ gnome-tweaks brave ];

  ### Other Examples ###

  # Install a custom font package
  #
  #    fonts.fontDir.enable = true;
  #    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
