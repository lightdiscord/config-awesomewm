{ lib, ... }:

with lib;

let
    bg_normal = "#000000A6";

    configuration = {
        theme = {
            font = "sans 10";
            inherit bg_normal;
        };

        lol = {
            mdr = "true";
        };
    };

    transform = config: concatStringsSep "\n" (flatten 
        (mapAttrsToList 
            (name: value: (optional true (if isAttrs value then transform value else "${name}-${value}"))) config));
in {
    home.file.".config/awesome-test/test.lua".text = transform configuration;
}