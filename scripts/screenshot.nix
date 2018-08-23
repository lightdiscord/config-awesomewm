let
    resolution = { x = 1920; y = 1080; };
    dpi = 80;

    pkgs = import <nixpkgs> {};
in import <nixpkgs/nixos/tests/make-test.nix> {
    machine = { pkgs, lib, ... }: with lib; let
        inherit (pkgs) callPackage alacritty;    
    in {
        users.users.arnaud = {
            isNormalUser = true;
            uid = 1000;
            description = "Professional Screenshoter";
            packages = [ alacritty ];
        };

        services.xserver = {
            enable = true;

            displayManager.auto = {
                enable = true;
                user = "arnaud";
            };

            windowManager = {
                default = mkForce "awesome";
                inherit ((callPackage ../default.nix {}).xsession.windowManager) awesome;
            };

            desktopManager.xterm.enable = false;

            resolutions = mkOverride 0 [ resolution ];
            virtualScreen = resolution;
            exportConfiguration = true;

            inherit dpi;
        };

        virtualisation.memorySize = 1 * 1024;
    };

    enableOCR = true;

    testScript = with pkgs.lib; let
        inherit (pkgs) callPackage;

        awesome = "~arnaud/.config/awesome";
        wallpapers = "${awesome}/themes/default/wallpapers";

        inherit (callPackage ../wallpapers.nix {}) landscape portrait;

        succeed = command: "$machine->succeed(\"${command}\");";

        link = type: files: concatMapStrings 
            (file: succeed("ln -nsf ${file} ${wallpapers}/${type}/${file.name}")) files;
    in ''
        $machine->waitForX;
        $machine->waitForFile("~arnaud/.Xauthority");
        $machine->succeed("xauth merge ~arnaud/.Xauthority");
        $machine->sleep(2);

        $machine->succeed("mkdir -p ${wallpapers}/{landscape,portrait}");
        $machine->succeed("cd ${./..} && find . -depth -type f | cpio -pamVd ${awesome}");

        ${ link "landscape" landscape }
        ${ link "portrait" portrait }

        $machine->succeed("chown -R arnaud:users ~arnaud");

        $machine->waitForWindow(qr/awesome/);
        $machine->sleep(5);

        $machine->execute("su - arnaud -c \"echo 'awesome.restart()' | awesome-client\"");
        $machine->succeed("su - arnaud -c 'alacritty &'");

        $machine->waitForWindow(qr/Alacritty/);
        $machine->waitForText("arnaud");
        $machine->sleep(5);

        $machine->screenshot("screenshot");
    '';
}