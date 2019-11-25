#!/bin/bash
set -e

mvn -B help:evaluate -Dexpression=project.version | tee project_version

SEMANTIC_VERSION_WITH_SNAPSHOT=$(cat project_version | grep -v INFO | grep -v WARNING)
SEMANTIC_VERSION=${SEMANTIC_VERSION_WITH_SNAPSHOT%-*}

MAJOR_AND_MINOR_VERSION=${SEMANTIC_VERSION%.*}
PATCH_VERSION=$(echo "$SEMANTIC_VERSION" | sed "s/$MAJOR_AND_MINOR_VERSION.//")

NEW_PATCH_VERSION=$(($PATCH_VERSION+1))
COMMIT_SHA=$(git rev-parse --short=12 HEAD)

VERSION="$MAJOR_AND_MINOR_VERSION.$NEW_PATCH_VERSION-$COMMIT_SHA"

# Update to semantic version with commit hash
echo "Setting release version: $VERSION"
mvn -B versions:set -DnewVersion="$VERSION"

echo "Running release"
mvn -B --settings maven-settings.xml deploy -Dmaven.wagon.http.pool=false

# Update to semantic SNAPSHOT version
VERSION="$MAJOR_AND_MINOR_VERSION.$NEW_PATCH_VERSION-SNAPSHOT"
echo "Setting SNAPSHOT version: $VERSION"
mvn -B versions:set -DnewVersion="$VERSION"
