### Custom stuff

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  {
    packages.x86_64-linux.oh-my-matrix = nixpkgs.stdenv.mkDerivation {
      name = "ohMyMatrix";
      src = self.oh-my-matrix;  # Point to the directory structure in your flake.
      installPhase = ''
        mkdir -p $out~/.oh-my-zhs/custom/plugins/oh-my-matrix
        cp -r $src/Plugins/oh-my-zsh/oh-my-matrix/* $out~/.oh-my-zsh/custom/plugins/oh-my-matrix
      '';
    };
  };
}