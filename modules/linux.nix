{inputs, ...}: {
   networking.hostName = "nixos"; # Define your hostname.
   i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.
   system.stateVersion = "24.05"; # Don't change it bro
}
