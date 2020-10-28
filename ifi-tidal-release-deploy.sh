#!/bin/bash
set -e # exit with nonzero exit code if anything fails

ARCH=$(dpkg --print-architecture)
SHC=$(which shc)

if [[ "${ARCH}" != "armhf" || -z "${SHC}" ]]; then
	echo "please do this script under iFi Streamer system, and install shc. Aborting..."
	exit 1
fi

[ -d ./ifi-tidal-release ] && rm -rf ./ifi-tidal-release
mkdir ifi-tidal-release

shc -U -f play.sh -o play
rm *.x.c

cp -r file-deploy.sh bin id_certificate pa_devs ifi-streamer-tidal-connect.service licenses play ifi-tidal-release/
rm -rf ifi-tidal-release/pa_devs/scripts ifi-tidal-release/pa_devs/src
cd ifi-tidal-release

echo "# ifi-tidal-release" > README.md

git init
git config user.name "Willard"
git config user.email "willardding@hotmail.com"
git add .
git commit -m "release commit"
git push --force "https://willardting:hua82345678@github.com/ifi-audio/ifi-tidal-release.git" master 2>&1

cd ..
rm -rf ./ifi-tidal-release
