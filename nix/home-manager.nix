{ config, lib, pkgs, ... }:

with lib;

let
		awesome = config.xsession.windowManager.awesome.enable;
		xsession = config.xsession.enable;
in {
		config = mkIf (awesome && xsession) {
				home.file.".config/awesome".source = pkgs.callPackage ./package.nix { };

				xsession.windowManager.awesome = {
						luaModules = import ./modules.nix { inherit pkgs; };
				};
		};
}
