{ stdenv, fetchurl, lib, linkFarm, symlinkJoin }:

with lib;

let
	config = sourceFilesBySuffices ../. ["lua" "png" "svg"];

	registerWallpaper = directory: { name, ... }@path: {
		name = "themes/default/wallpapers/${directory}/${name}";
		inherit path;
	};

	mappedWallpapers = mapAttrsToList
		(directory: map (registerWallpaper directory))
		(import ./wallpapers.nix { inherit fetchurl; });

	wallpapers = linkFarm "wallpapers" (flatten mappedWallpapers);
in symlinkJoin {
	name = "awesomewm-config";
	paths = [ config wallpapers ];
}
