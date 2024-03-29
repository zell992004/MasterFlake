# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, home-manager, hyprland, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "nvidia" ];
  networking.hostName = "hyprland"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
#    services.xserver.enable = true;
     
#    services.xserver.displayManager.gdm.wayland = true;
  # Enable the Cinnamon Desktop Environment.
#    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zell = {
    isNormalUser = true;
    description = "zell";
    extraGroups = [ "networkmanager" "wheel" "plocate" "vboxusers"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "zell";

  # Allow unfree packages
  nixpkgs.config = {
	allowUnfree = true;
  	firefox = {
		enableGoogleTalkPlugin = true;
		enableAdobeFlash = true;
		};
#	chromium = {
#		enable = true;
	#	enablePepperFlash = true;
#		};
	};
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    chromium
    github-desktop
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  users.defaultUserShell = pkgs.zsh;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enablialue read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

nix.settings.experimental-features = [ "nix-command" "flakes"];

  programs.hyprland ={
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.avahi.enable  = true;

  hardware = {
    opengl = {
    enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
    };
    nvidia= {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
     prime ={
      sync.enable = true;
      intelBusId = "PCI:1:00:0";
      nvidiaBusId = "PCI:1:00:0";
     };
    };
  };
xdg = {
  sounds.enable = true;
  autostart.enable = true;
      portal = {
        enable = true;
        wlr.enable = true;
        xdgOpenUsePortal = true;
#      extraPortals = [ pkgs.xdg-desktop-portal-hyprland 
#       ];
      };
   };
   virtualisation.virtualbox = {
    host = {
    enable = true;
    enableExtensionPack = true;
   };
 };

  programs.steam = {
        enable = true;
    };
    programs.zsh.enable = true;
}
