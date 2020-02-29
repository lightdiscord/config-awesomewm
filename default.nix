{ callPackage }:

{
	files.".config/awesome" = callPackage ./nix/configuration.nix { };
}
