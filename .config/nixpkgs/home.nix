{ config, pkgs, lib, ... }:

with lib;

let

  gitName = "Arian-D";
  gitEmail = "ArianDehghani@protonmail.com";
  home = lib.getEnv "HOME";

in

{
  imports =
    [
      ./firefox/firefox.nix
    ];

  home.packages = with pkgs; [
    # Rust
    cargo
    # LaTeX LSP
    lua53Packages.digestif
  ];


  programs = {
    alacritty = {
      enable = true;
      settings = {
        cursor.style = "Beam";
        font.normal.family = "Iosevka Nerd Font";
        font.size = 9;
        background_opacity = 0.3;
      };
    };

    htop = {
      enable = true;
      treeView = true;
    };
    
    git = {
      enable = true;
      userName = gitName;
      userEmail = gitEmail;
    };
    
    gpg.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };
    
    bat.enable = true;
    
    rofi = {
      enable = true;
      terminal = "alacritty";
      scrollbar = false;
      location = "top-left";
      theme = "DarkBlue";
      font = "DejaVu Sans extralight 24";
      extraConfig = ''
        show-icons: true;
      '';
    };
    
    zathura.enable = true;
  };
  /*
  programs.home-manager = {
    enable = true;
    path = home + "playground/home-manager";
  };
  */
}
