{ pkgs, ... }:

{
  xsession.windowManager.awesome = {
    enable = true;
    luaModules = [ pkgs.luaPackages.luafilesystem ];
  };

  home.file.".config/awesome".source = pkgs.callPackage ./nix/configuration.nix { };
}
