{
    programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhs;
        mutableExtensionsDir = true;
#	userSettings = {
#		"window.titleBarStyle": "custom"
#	};
    };
}
