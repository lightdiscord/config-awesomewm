{ pkgs, ... }:

{
	home.file.".config/awesome".source = pkgs.callPackage ./nix/configuration.nix { };
}
