import <nixpkgs/nixos/tests/make-test.nix> {
	machine = { pkgs, lib, ... }: {
		imports = [
			../nixos.nix
		];

		users.users.arnaud = {
			isNormalUser = true;
			uid = 1000;
			description = "Professional Screenshoter";
			packages = [];
		};

		environment.extraInit = let awesome = pkgs.callPackage ../package.nix {}; in ''
			mkdir -p ~arnaud/.config
			ln -s ${awesome} ~arnaud/.config/awesome
		'';

		services.xserver = let resolution = { x = 1920; y = 1080; }; in {
			enable = true;

			windowManager.default = lib.mkForce "awesome";
			desktopManager.xterm.enable = false;
			resolutions = lib.mkOverride 0 [ resolution ];
			virtualScreen = resolution;
			exportConfiguration = true;
			dpi = 80;

			displayManager.auto = {
				enable = true;
				user = "arnaud";
			};
		};

		virtualisation.memorySize = 1 * 1024;
	};

	enableOCR = true;

	testScript = ''
		$machine->waitForX;
		$machine->waitForFile("~arnaud/.Xauthority");
		$machine->succeed("xauth merge ~arnaud/.Xauthority");

		$machine->sleep(15);

		$machine->screenshot("screenshot");
	'';
}
