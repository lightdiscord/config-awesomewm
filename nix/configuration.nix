let
	dependencies = {
		nixpkgs = import ./dependencies/nixpkgs.nix { };
	};

	inherit (dependencies.nixpkgs) stdenv fetchurl lib;

	wallpapers = import ./wallpapers.nix;

	lines = lib.concatStringsSep "\n";
	link = orientation: wallpaper: "ln -s ${wallpaper} $out/themes/default/wallpapers/${orientation}";

	src = lib.sourceFilesBySuffices ../. ["lua" "png"];

in stdenv.mkDerivation {
	name = "awesome-config";

	installPhase = ''
		mkdir -p $out

		cp -ra $src/. $out
		chmod -R u+w $out

		mkdir -p $out/themes/default/wallpapers/{landscape,portrait}

		${ lines (map (link "landscape") wallpapers.landscape) }
		${ lines (map (link "portrait") wallpapers.portrait) }
	'';

	inherit src;
}
