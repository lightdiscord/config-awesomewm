{ config, pkgs, ... }:

{
    xsession.windowManager.awesome = {
        enable = config.xsession.enable;
        luaModules = import ./modules.nix { inherit pkgs; };
    };

    home.file.".config/awesome".source = pkgs.callPackage ./package.nix { };
}