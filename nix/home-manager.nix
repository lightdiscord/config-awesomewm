{ config, lib, pkgs, ... }:

with lib;

let
	awesome = config.xsession.windowManager.awesome.enable;
	xsession = config.xsession.enable;
in {
	config = mkIf (awesome && xsession) {
		home.file.".config/awesome".source = import ./configuration.nix;

		xsession.windowManager.awesome.luaModules = import ./modules.nix { inherit (pkgs) luaPackages; };
	};
}
