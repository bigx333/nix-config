
{ pkgs, ... }:

{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
 #system.configurationRevision = self.rev or self.dirtyRev or null;
}
