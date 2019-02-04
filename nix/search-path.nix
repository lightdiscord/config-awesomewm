let
	nixpkgs = import ./dependencies/nixpkgs.nix { };

	getLuaPath = lib: dir: "${lib}/${dir}/lua/${nixpkgs.luaPackages.lua.luaversion}";

	makeSearchPath = nixpkgs.lib.concatMapStrings (path:
		" --search ${getLuaPath path "share"}" +
    " --search ${getLuaPath path "lib"}"
	);
in makeSearchPath (import ./modules.nix { pkgs = nixpkgs; })
