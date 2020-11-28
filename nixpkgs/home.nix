{ config, pkgs, lib, ... }:

with lib;

let

  gitName = "Arian-D";
  gitEmail = "ArianDehghani@protonmail.com";

  home = getEnv "HOME";

  wallpaper = pkgs.fetchurl {
    url = https://i.imgur.com/GTdaXyT.jpg;
    sha256 = "1s3g071ic330zp8bb4zmkrxi6s9gapyj9mi18riwlqy6kj93mpws";
  };

  networkingPackages = with pkgs; [
    nmap
    openvpn netcat-gnu
  ];

  devPackages = with pkgs; [    
    texlive.combined.scheme-basic
    github-cli
    nix-direnv
    # Haskal
    (haskellPackages.ghcWithPackages(hs: with hs; [
      stack
      hoogle
    ]))
    # Lisps
    sbcl
    guile
    racket
    # LSPs
    rnix-lsp
    nodePackages.pyright
  ];
in

{
  imports =
    [
      ./firefox/firefox.nix
      ./emacs.nix
    ];

  home.file.wallpaper.source = wallpaper;
  home.file.".fehbg".source = "${wallpaper}";
  home.packages = with pkgs; [
    pulseeffects
    tty-clock
    neofetch
    libreoffice
    remmina
    higan
    spectacle
    nyxt
    pinentry.qt
    torsocks                    # To be used with my remote server
    gimp-with-plugins
    godot
    discord jitsi-meet-electron
  ]
  ++ networkingPackages
  ++ devPackages;

  home.sessionVariables = {
    EDITOR = "emacsclient";
    WALLPAPER = "${wallpaper}";
  };
  
  home.file.".stack/config.yaml".text = ''
  allow-newer: true
  nix:
    enable: true
  '';

  programs = {
    mpv.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
	  };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [
          "git"
          "docker"
          "python"
          "cabal"
          "stack"
          "man"
          "sudo"
          "nmap"
        ];
      };
    };

    alacritty = {
      enable = true;
      settings = {
        cursor.style = "Beam";
        font.normal.family = "Iosevka Nerd Font";
        font.size = 10;
        background_opacity = 0.9;
      };
    };

    chromium.enable = true;

    htop = {
      enable = true;
      treeView = true;
    };
    
    git = {
      enable = true;
      userName = gitName;
      userEmail = gitEmail;
      ignores = [ "*~" ];
      signing = {
        key = "900AFEBE832C4F80034DF1B811F9FBCB5C496EA8";
        signByDefault = true;
      };
    };
    
    lsd = {
      enable = true;
      enableAliases = true;
    };
    
    bat.enable = true;
    
    rofi = {
      enable = true;
      terminal = "alacritty";
      scrollbar = false;
      location = "center";
      theme = "DarkBlue";
      font = "DejaVu Sans extralight 24";
      extraConfig = "rofi.show-icons: true";
    };
    
    feh.enable = true;
    zathura.enable = true;
    gpg.enable = true;
  };
  
  services = {
    gpg-agent = {
      enable = true;
      extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    };

    # Notification
    dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "300 x5-30+50";
          frame_color = "#eceff1";
          font = "Droid Sans 24";
        };
        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
		};

    polybar = {
      enable = true;
      script = "polybar mybar &";
      extraConfig = ''
      [bar/mybar]
      modules-right = date
      
      [module/date]
      type = internal/date
      interval = 1.0
      date = %Y-%m-%d %H:%M:%S
      '';
    }; 
  };
}
