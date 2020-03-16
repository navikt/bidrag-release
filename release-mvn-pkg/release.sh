#!/bin/bash
set -e

if [ ! -z "$INPUT_SRC_FOLDER" ]
then
  cd "$INPUT_SRC_FOLDER"
fi

echo "Working directory"
pwd

if [ "$INPUT_IS_RELEASE_CANDIDATE" != "true" ]
then
  git reset --hard
  echo "The artifact is not a release candidate, git reset --hard..."
  exit 0;
fi

echo "Running release"
mvn -B --settings maven-settings.xml deploy -e -DskipTests -Dmaven.wagon.http.pool=false

# Update to new SNAPSHOT version
echo "Setting SNAPSHOT version: $INPUT_NEW_SNAPSHOT_VERSION"
mvn -B versions:set -DnewVersion="$INPUT_NEW_SNAPSHOT_VERSION"
