#!/bin/bash
set -e

NEW_SNAPSHOT_VERSION=$(cat .new-snapshot-version)

echo "Running release"
mvn -B --settings maven-settings.xml deploy -Dmaven.wagon.http.pool=false

# Update to new SNAPSHOT version
echo "Setting SNAPSHOT version: $NEW_SNAPSHOT_VERSION"
mvn -B versions:set -DnewVersion="$NEW_SNAPSHOT_VERSION"
