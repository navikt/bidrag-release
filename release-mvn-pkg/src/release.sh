#!/bin/bash
set -e

if [ ! -f .is-release-candidate ]
  then
    if [ ! -f .is-not-release-candidate ]
      then
        >&2 echo "ERROR! No verification of artifact is eligable for deploy has been done"
        exit 1;
    fi

    echo This is not a release candidate. Will not deploy artifact
    exit 0;
fi

if [ ! -f .new-snapshot-version ]
  then
    >&2 echo .new-snapshot-version is not present
    exit 1;
fi

NEW_SNAPSHOT_VERSION=$(cat .new-snapshot-version)

echo "Running release"
mvn -B --settings maven-settings.xml deploy -Dmaven.wagon.http.pool=false

# Update to new SNAPSHOT version
echo "Setting SNAPSHOT version: $NEW_SNAPSHOT_VERSION"
mvn -B versions:set -DnewVersion="$NEW_SNAPSHOT_VERSION"
