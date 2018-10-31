{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

pkgs.stdenv.mkDerivation {
	name = "awesome-screenshot";

	src = import ./machine.nix {};

	buildInputs = with pkgs; [ imagemagick ];

	installPhase = ''
		mkdir -p $out

		convert screenshot.png -quality 50% $out/screenshot.jpg
	'';
}
