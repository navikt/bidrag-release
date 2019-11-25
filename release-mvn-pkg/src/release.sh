#!/bin/bash
set -e

echo "Running release"
mvn -B --settings maven-settings.xml deploy -Dmaven.wagon.http.pool=false

# Update to semantic SNAPSHOT version
VERSION="$MAJOR_AND_MINOR_VERSION.$NEW_PATCH_VERSION-SNAPSHOT"
echo "Setting SNAPSHOT version: $VERSION"
mvn -B versions:set -DnewVersion="$VERSION"
