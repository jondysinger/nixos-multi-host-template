/* File:        modules/common.nix
   Description: This shared module declares common settings which are not specific to the user or desktop environment
                (GUI apps).
*/

{ pkgs, ... }: {
  # Both of these experimental features are required for flakes to work.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Optimizations
  nix.settings.auto-optimise-store = true; # Deduplicates files the nix store
  nix.gc.automatic = true; # Garbage collection to removes unused packages
  nix.gc.dates = "weekly"; # How often garbage collection runs
  nix.gc.options = "--delete-older-than 7d"; # Auto removes old generations

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Packages to install that are either CLI tools or library dependencies
  environment.systemPackages = with pkgs;
    [
      # Network tools
      #    wget
      #    curl

      # Archive tools
      #    unzip

      # Development tools
      #    git
      #    gcc
      #    gnumake
    ];

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Networking and security
  networking.networkmanager.enable = true;
  security.sudo.wheelNeedsPassword = false;
  nixpkgs.config.allowUnfree = true;

  ### Other Examples ###

  # Time and localization
  #
  #    time.timeZone = "America/Los_Angeles";
  #    i18n.defaultLocale = "en_US.UTF-8";
  #    i18n.extraLocaleSettings = {
  #      LC_ADDRESS = "en_US.UTF-8";
  #      LC_IDENTIFICATION = "en_US.UTF-8";
  #      LC_MEASUREMENT = "en_US.UTF-8";
  #      LC_MONETARY = "en_US.UTF-8";
  #      LC_NAME = "en_US.UTF-8";
  #      LC_NUMERIC = "en_US.UTF-8";
  #      LC_PAPER = "en_US.UTF-8";
  #      LC_TELEPHONE = "en_US.UTF-8";
  #      LC_TIME = "en_US.UTF-8";
  #    };

  # Enabling other services
  #
  #    services.openssh.enable = true;

  system.stateVersion = "25.05";
}
