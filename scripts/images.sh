#! /usr/bin/env nix-shell
#! nix-shell -i bash -p imagemagick

set -e

rm -rf dist

mkdir dist

convert result/screenshot.png -quality 50% dist/screenshot.jpg