{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    # Use systemd-boot instead of grub
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    }

    kernelPackages = pkgs.linuxPackages_latest;
    
    # Show logo on startup
    plymouth.enable = true;
  }

  # Greeter
  # SystemD can use TTY1 as log
  systemd.services = {
    "autovt@tty1".enable = false;
    greetd.unitConfig = {
      After = [ "getty@tty1.service" ];
      Conflicts = [ "getty@tty1.service" ];
    };
  };
  boot.kernelParams = [ "console=tty1" ];

  # Run GreetD on TTY2
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };  
  };

  networking.hostName = "klabun-desktop";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  time.timeZone = "America/Los_Angeles";

  # Setup locale and terminal font
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "##rootpasswd##";

  users.users.##username## = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/##username##/";
    extraGroups = [ "wheel" "networkmanager" ];
    initialHashedPassword = "##rootpasswd##";
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;


  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = false;  
  services.xserver.layout = "us";

  # Enable touchpad support.
  # It is needed to explicitly disable libinput if we want to use synaptics
  services.xserver.libinput.enable = false;

  # Enable Lenovo/IBM touchpad support
  services.xserver.synaptics.enable = true;

  # Enable for Gnome Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;


  # Enable SwayWM
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      xwayland
      kanshi
      wl-clipboard
      mako # notification daemon
      kitty
      wofi
      swaybg
      waybar
    ];
  };

  programs.fish.enable = true;

  # System-wide packages
  environment = {
    systemPackages = with pkgs; [
      curl git wget unrar unzip zip
      firefox-wayland google-chrome
      brightnessctl htop neofetch pavucontrol pulseaudio easyeffects
      zoom-us
      xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr
      mpv streamlink youtube-dl obs-studio obs-studio-plugins.wlrobs
      xdg-user-dirs
      slurp
      virt-manager
      kanshi wdisplays
      rustup
    ];

    interactiveShellInit = ''
      if [ ! -f ~/.config/nixpkgs/config.nix ]
        then
          mkdir -p ~/.config/nixpkgs/
          echo  '{ allowUnfree = true; }' > ~/.config/nixpkgs/config.nix
      fi
    '';
  }

  services = {
    journald.extraConfig = "SystemMaxUse=500M";
    printing.enable = true;
  }

  fonts.fonts = with pkgs; [
  #   noto-fonts
  #   noto-fonts-cjk
  #   noto-fonts-emoji
  #   liberation_ttf
  #   fira-code
  #   fira-code-symbols
  #   mplus-outline-fonts
  #   dina-font
  #   proggyfonts
    pkgs.dejavu_fonts
    pkgs.font-awesome
    #pkgs.Iosevka
    pkgs.font-awesome_5
    pkgs.cantarell-fonts
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
  ];

  # Enable sound.
  sound.enable = true;

  # Enable BT
  hardware.bluetooth.enable = true;

  # Enable pulseaudio with BT support
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.11"; # Did you read the comment?
}
