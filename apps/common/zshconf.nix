
  { # ZSH
 # programs.nano.syntaxHighlighting = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
   # enableVteIntegrations.enable = true;

   # initExtra = "
   #     ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)
   #     ";
  
    syntaxHighlighting = {
      enable = true;
     
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
  };
}


