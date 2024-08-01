{inputs, ...}: {
  imports = [
    ./modules/nix-core.nix
    ./modules/system.nix
    ./modules/host-users.nix
    ./modules/apps.nix
    ./modules/hardware-configuration.nix
  ];
}
