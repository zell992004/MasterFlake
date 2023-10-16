
  { # ZSH
 # programs.nano.syntaxHighlighting = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
   # enableVteIntegrations.enable = true;

   # initExtra = "
   #     ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)
   #     ";
  
    syntaxHighlightingModule = {
      enable = true;
      styles = {
      "ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)";
      }

    };
    
    #ohmyzsh = { 
     #enable = true;
     # extraConfig = "
     # ZSH_THEME = random
     #   ";
    #};

    shellAliases = {
      _ = "sudo";
      h = "history";
      hg = "history | grep ";
      n = "sudo nixos-rebuild switch --flake MasterFlake/#";
      clrgenhist = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2";
    };

    zsh_theme_enable = "prompt_powerlevel9k_teardown";

     historyModule = {
        expireDuplicatesFirst = true;
        save = 100000000;
        size = 1000000000;
      };

  };
}


