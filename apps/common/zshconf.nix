
  
  { # ZSH
 # programs.nano.syntaxHighlighting = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    #dotDir = ".config/zsh";
     history = {
      #  enable = true;
        expireDuplicatesFirst = true;
        save = 100000000;
        size = 1000000000;
        };
    syntaxHighlighting = {
    enable = true;
   # styles = [ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)
    
    #];
    };
    
    shellAliases = {
      _ = "sudo";
      h = "history";
      hg = "history | grep ";
      n = "sudo nixos-rebuild switch --flake MasterFlake/#";
      matrix = "python ~/MasterFlake/apps/common/Plugins/matrix.py";
      clrgenhist = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2";
      zsh_theme_enable = "prompt_powerlevel9k_teardown";
      zsh_theme_disable = "prompt_powerlevel9k_setup";
    };
  };

 programs.zsh.oh-my-zsh = {
      enable = true;
    #  plugins = [oh-my-matrix];
      theme = "ZSH_THEME = amuse";
    };
}

