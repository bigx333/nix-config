{ lib, config, ... }: {
  programs.fish = {
    enable = true;
#    enableCompletion = true;
#    initExtra = ''
#      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
#    '';
    #useBabelfish = true;
    #shellInit = ''
    #  export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    #'';
    #interactiveShellInit = lib.strings.concatStrings [
    #  ''
    #  ''
    #    eval "''$(${config.homebrew.brewPrefix}/brew shellenv)";
    #  ''
    #];
  };

  home.shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    grep = "rg";
    ff = "fzf --preview 'bat --style=numbers --color=always {}'";
  };
}
