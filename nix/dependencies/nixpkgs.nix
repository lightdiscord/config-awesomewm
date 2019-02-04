let
	expression = builtins.tryEval <nixpkgs>;
	fallback = builtins.fetchGit {
		url = "git@github.com:NixOS/nixpkgs.git";
		rev = "e0fad4b9c57b6d7f67a9b667cf80850bcca57e30";
	};
in import (if expression.success then expression.value else fallback)
