{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    zoxide # A faster way to navigate your filesystem
    fd
    bat

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    pokemonsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    #caddy
    gnupg
    nil

    # productivity
    glow # markdown previewer in terminal
  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    fd = {
      enable = true;
    };

    fzf = {
      enable = true;
    };

    bat = {
      enable = true;
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
    };
  };
}
