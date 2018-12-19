{ pkgs, ... }:

with pkgs.luaPackages; [
	lfs
	luasocket
]
