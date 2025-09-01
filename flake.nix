/* File:        flake.nix
   Description: Primary flake for the nixos configuration. Defines all other modules to import.
   Usage:       Execute as `sudo nixos-rebuild switch --flake /etc/nixos#$HOSTNAME`
*/

{
  description = "NixOS Multi-Host Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "<your-username>";
      userDescription = "Your Name";

      # mkNixosConfiguration is a helper function that generates a NixOS system configuration for a given host. It
      # assembles all required modules, passes custom arguments (like username and userDescription), and returns the
      # result of nixpkgs.lib.nixosSystem. Modules are evaluated in the order they are listed, so shared settings
      # can be overridden by host-specific modules later in the list. When a conflict arises during a build (two
      # modules declaring the same setting) You can resolve that conflict by using lib.mkDefault in shared modules to
      # specify a setting as a default value or lib.mkForce in host-specific modules to specify that setting overrides
      # all other values.
      mkNixosConfiguration = hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit hostName;
            username = username;
            userDescription = userDescription;
          };

          modules = [
            # Modules shared by all hosts. This structure can easily be extended to separate out configurations further
            # into more specific modules. Just add a module in the `modules` directory and then add the import here.
            "${self}/modules/common.nix"
            "${self}/modules/desktop.nix"
            (import "${self}/modules/users.nix" {
              inherit username userDescription;
            })

            # Home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import "${self}/home/home.nix";
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                username = username;
                # Host specific home manager overrides
                hostConfigPath = "${self}/hosts/${hostName}/home.nix";
              };
            }

            # Modules for the specified host
            "${self}/hosts/${hostName}/configuration.nix"
            "${self}/hosts/${hostName}/hardware-configuration.nix"
          ];
        };

      # The following lines dynamically enumerate all host directories and creates an attribute set mapping each host
      # name to its NixOS configuration. This does not build all host configurations at once; it simply defines them
      # as attributes. When you run a flake command (e.g., nixos-rebuild switch --flake /etc/nixos#$HOSTNAME),
      # only the configuration for the specified host is actually built and evaluated. The other hosts remain
      # unevaluated until explicitly requested. This gives us the ability to manage multiple hosts from a single flake.
      hostDirs = builtins.readDir ./hosts;
      nixosConfigurationsFromHosts = nixpkgs.lib.mapAttrs (hostName: type:
        if type == "directory" then mkNixosConfiguration hostName else null)
        hostDirs;

    in { nixosConfigurations = nixosConfigurationsFromHosts; };
}
