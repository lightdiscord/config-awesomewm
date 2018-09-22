{ pkgs, lib, ... }:

with lib;

{
    xsession = {
        enable = true;
        windowManager.awesome = {
            enable = true;
            luaModules = with pkgs.luaPackages; [
                lfs
                luasocket
            ];
        };
    };

    home.file = let
        inherit (pkgs.callPackage ./wallpapers.nix {}) landscape portrait;

        folder = folder: file:  
            toString (./themes/default/wallpapers + "/${folder}/${file.name}");

        source = source: { inherit source; };

        transform = path: files: 
            listToAttrs (map (file: nameValuePair (folder path file) (source file)) files);

    in transform "landscape" landscape // transform "portrait" portrait;
}
