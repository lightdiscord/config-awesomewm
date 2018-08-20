#!/usr/bin/env bash

set -e

rm -rf dist

mkdir dist

nix-shell -p imagemagick --run "convert result/screenshot.png -quality 50% dist/screenshot.jpg"