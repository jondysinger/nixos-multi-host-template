/* File:        modules/users.nix
   Description: This shared module declares settings which are related to user accounts.
*/

{ username, userDescription, ... }: {
  # Passed through from flake.nix. Configure the user as needed.
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [ "networkmanager" "wheel" ];
    # Example: Storing your public SSH key
    #
    #    openssh = {
    #      authorizedKeys.keys = [
    #        "ssh-ed25519 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA your.user@mail.server"
    #      ];
    #    };
  };
}
