{ lib, stdenv, fetchurl }:

with lib;

let
    wallpapers = import ./wallpapers.nix { inherit fetchurl; };

    lines = concatStringsSep "\n";
    link = orientation: wallpaper: "ln -s ${wallpaper} $out/themes/default/wallpapers/${orientation}";

in stdenv.mkDerivation {
    name = "awesome-config";

    src = ./..;

    installPhase = ''
        mkdir -p $out
        
        find $src -type f -printf '%P\n' \
            | grep -iE 'lua$|png$' \
            | xargs -i cp --parents {} $out

        mkdir -p $out/themes/default/wallpapers/{landscape,portrait}

        ${ lines (map (link "landscape") wallpapers.landscape) }
        ${ lines (map (link "portrait") wallpapers.portrait) }
    '';    
}