 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;
        package = (import inputs.nixpkgs-vscode1 {
            system = pkgs.system;
        })
        .vscode;
    };
}
