#!/bin/bash
set -e

if [ ! -z "$INPUT_SRC_FOLDER" ]
then
  cd "$INPUT_SRC_FOLDER"
fi

echo "Working directory"
pwd

if [ ! -f .is-release-candidate ]
  then
    if [ ! -f .is-not-release-candidate ]
      then
        >&2 echo "::error No verification of artifact is eligable for deploy has been done, please use '/release-verify-auto-deploy'"
        exit 1;
    fi

    git reset --hard
    echo "The artifact is not a release candidate, git reset --hard..."
    exit 0;
fi

if [ ! -f "$INPUT_NEW_SNAPSHOT_VERSION_FILE" ]
  then
    >&2 echo "::error $INPUT_NEW_SNAPSHOT_VERSION_FILE is not present"
    exit 1;
fi

echo "Running release"
mvn -B --settings maven-settings.xml deploy -e -DskipTests -Dmaven.wagon.http.pool=false

NEW_SNAPSHOT_VERSION=$(cat $INPUT_NEW_SNAPSHOT_VERSION_FILE)

# Update to new SNAPSHOT version
echo "Setting SNAPSHOT version: $NEW_SNAPSHOT_VERSION"
mvn -B versions:set -DnewVersion="$NEW_SNAPSHOT_VERSION"
