{
    let
        pkgs = import (buitins.fetchGit {
            name = "old-code";
            url = "https://github.com/NixOS/nixpkgs";
            ref = "refs/heads/nixpkgs-unstable";
            rev = "976fa3369d722e76f37c77493d99829540d43845";
        }) {};

        myPkg = pkgs.vscode;
    in 
    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        mutableExtensionsDir = true;
	userSettings = {
		"window.titleBarStyle": "custom";
	};
    };
}
