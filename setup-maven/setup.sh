#!/bin/bash
set -e

echo "Setup maven"

MAVEN_REPO=~/.m2

if [ -d "$MAVEN_REPO" ]; then
  echo "Using existing $MAVEN_REPO"
or
  echo "Creating $MAVEN_REPO"
  mkdir "$MAVEN_REPO"
fi

echo "<settings><servers><server><id>github</id><username>$GITHUB_ACTOR</username><password>$GITHUB_TOKEN</password></server></servers></settings>" > "$MAVEN_REPO"/settings.xml
