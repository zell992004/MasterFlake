 {inputs, pkgs, inputs, ...}:{

    programs.vscode = {
        enable = true;
        package = (import inputs.nixpkgs-vscode1 {
            system = pkgs.system;
        })
        .vscode;
        mutableExtensionsDir = true;
    };
}
