/*
  File:        modules/home.nix
  Description: This shared module declares home-manager settings which are common to all hosts.
*/

{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  ### Packages only available to the defined user ###
  home.packages = with pkgs; [
    # Neovim and dependencies
    #   neovim
    #   ripgrep
    #   tree-sitter

    # LSP servers
    #   lua-language-server
    #   nil

    # Formatters and linters
    #   stylua
    #   nixfmt

    # Other useful tools
    #   delta
    #   lazygit
    #   fzf
  ];

  ### Other Examples ###

  # Trash entry (so we can add to favorites)
  #    xdg.desktopEntries."trash" = {
  #      name = "Trash";
  #      comment = "View and restore deleted files";
  #      icon = "user-trash";
  #      exec = "${pkgs.nautilus}/bin/nautilus trash:///";
  #      terminal = false;
  #      type = "Application";
  #      categories = [ "Utility" "Filesystem" ];
  #    };

  # Gnome settings
  #
  #    dconf.settings = {
  #      "org/gnome/shell" = {
  #        # Applications/links that appear in the dock
  #        favorite-apps = [
  #          "brave-browser.desktop"
  #          "org.gnome.Nautilus.desktop"
  #          "trash.desktop"
  #        ];
  #      };
  #      "org/gnome/desktop/interface" = { clock-format = "12h"; };
  #    };

  # Define directories controlled by home-manager
  # Example: If you want to keep your neovim config in a sub directory here called nvim and have home-manager deploy it
  # to the appropriate .config directory.
  #
  #     home.file.".config/nvim" = {
  #       source = ./nvim;
  #       recursive = true;
  #     };

  # Customize your bash configuration
  #
  #     programs.bash = {
  #       enable = true;
  #       sessionVariables = {
  #         EDITOR = "nvim";
  #         VISUAL = "nvim";
  #       };
  #       # Some helpful shortcuts
  #       shellAliases = {
  #         norb = "sudo nixos-rebuild switch --flake /etc/nixos#$HOSTNAME";
  #         nupd = "sudo nix flake update";
  #       };
  #     };

  # Customize vscode
  #
  #    programs.vscode = {
  #      enable = true;
  #      mutableExtensionsDir = true;
  #      profiles.default = {
  #        extensions = with pkgs.vscode-extensions; [
  #          jnoortheen.nix-ide
  #          github.copilot
  #          github.copilot-chat
  #        ];
  #        userSettings = {
  #          "[nix]" = {
  #            "editor.defaultFormatter" = "jnoortheen.nix-ide";
  #            "editor.formatOnSave" = true;
  #          };
  #          "nix.enableLanguageServer" = true;
  #          "nix.serverPath" = "nil";
  #          "nix.serverSettings" = {
  #            "nil" = { "formatting" = { "command" = [ "nixfmt" ]; }; };
  #          };
  #        };
  #      };
  #    };
}
