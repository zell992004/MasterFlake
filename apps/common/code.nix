 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        package = (import inputs.nixpkgs-vscode);
        mutableExtensionsDir = true;
	userSettings = {
		"window.titleBarStyle": "custom";
	};
    };
}
