 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        package = (import inputs.nixpkgs-vscode1 {
            system = pkgs.system;
        })
        .vscode1;
        mutableExtensionsDir = true;
    };
}
