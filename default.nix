{ pkgs, lib, ... }:

with lib;

let
    landscape = imap0 (_: pkgs.fetchurl) [
        {
            url = https://images.wallpaperscraft.com/image/akio_bako_anime_sunset_girl_clouds_103086_3840x2160.jpg;
            sha256 = "01gh8mhwn39hng9vdfmlp0q8qygysxfclj0br5199dmrr88apn24";
        }
        {
            url = https://images.wallpaperscraft.com/image/girls_und_panzer_nishizumi_miho_tank_hill_girl_100910_3840x2160.jpg;
            sha256 = "0m6gj65qvzhszn3w3pkmpjvx29s4w0jcigzq2cc2f2cmx03fz8f6";
        }
    ];

    portrait = imap0 (_: pkgs.fetchurl) [
        {
            url = https://images.wallpaperscraft.com/image/mountains_peaks_sky_125630_2160x3840.jpg;
            sha256 = "0igk20lxkslvj931lf6qcvb3pqdazqmz46p17vx4ljb4563fqppy";
        }
        {
            url = https://images.wallpaperscraft.com/image/starry_sky_mountains_night_125119_2160x3840.jpg;
            sha256 = "06gbgm595j4hprald8z4m94kf1w57r37v0211hvx561s48vvmlvp";
        }
        {
            url = https://images.wallpaperscraft.com/image/stones_balance_shapes_124852_2160x3840.jpg;
            sha256 = "02p4a1dbwbdnv01wnvc1xybil021gbfpswakpzqr3f6vkl8947ys";
        }
    ];

in {
    xsession = {
        enable = true;
        windowManager.awesome = {
            enable = true;
            luaModules = with pkgs; [
                luaPackages.lfs
            ];
        };
    };

    home.file = let
        folder = folder: file: 
            ".config/awesome/themes/default/wallpapers/${folder}/${file.name}";

        source = source: { inherit source; };
    
        transform = path: files: 
            listToAttrs (map (file:
                nameValuePair (folder path file) (source file)) files);

    in transform "landscape" landscape // transform "portrait" portrait;
}