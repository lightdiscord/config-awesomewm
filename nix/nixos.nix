{ config, pkgs, ... }:

{
    services.xserver.windowManager.awesome = {
        enable = config.services.xserver.enable;
        luaModules = import ./modules.nix { inherit pkgs; };
    };
}