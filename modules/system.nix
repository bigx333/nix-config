{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;
  environment.shells = [
    pkgs.fish
  ];

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";
}
