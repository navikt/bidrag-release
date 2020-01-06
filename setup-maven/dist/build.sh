#!/bin/bash
set -e

echo "Setup maven"

mkdir ~/.m2
echo "<settings><servers><server><id>github</id><username>$GITHUB_ACTOR</username><password>$GITHUB_TOKEN</password></server></servers></settings>" > ~/.m2/settings.xml
