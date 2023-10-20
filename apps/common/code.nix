 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;
        package = (import inputs.nixpkgs-vscode {
            system = pkgs.system;
            config.allowUnfree = true;
        })
        .vscode;
    };
}
