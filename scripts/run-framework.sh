#!/bin/sh

cd "../generated/"
echo "Current working directory: $PWD"

for FILE in *; do sh "./$FILE"; sleep 10; done;

