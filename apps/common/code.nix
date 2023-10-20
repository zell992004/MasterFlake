 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;
        package = (import inputs.nixpkgs-vscodes {
            system = pkgs.system;
            config.allowUnfree = true;
        })
        .vscode;
    };
}
