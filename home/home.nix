/* File:        home/home.nix
   Description: This module is just used to import the other modules
*/

{ pkgs, lib, hostConfigPath, ... }: {
  home.stateVersion = "25.05";
  imports = [
    ### Base home-manager configuration (lowest priority) ###
    (import ./common.nix { inherit pkgs lib; })

    # Using this structure, you can easily split out your configurations into additional modules as you see fit.
    # Just add the .nix file into this directory and include the import here.

    ### Host-specific home-manager overrides (highest priority) ###
    (import hostConfigPath { inherit pkgs lib; })
  ];
}
