 {inputs, pkgs, ...}:{

    programs.vscode = {
        enable = true;
        package = (import inputs.nixpkgs-vscode1);
        mutableExtensionsDir = true;
    };
}
