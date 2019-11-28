#!/bin/bash
set -e

mvn -B help:evaluate -Dexpression=project.version | tee project_version

SEMANTIC_VERSION_WITH_SNAPSHOT=$(cat project_version | grep -v INFO | grep -v WARNING)  # eks: 1.2.3-SNAPSHOT
SEMANTIC_VERSION=${SEMANTIC_VERSION_WITH_SNAPSHOT%-*}                                   # > 1.2.3

MAJOR_AND_MINOR_VERSION=${SEMANTIC_VERSION%.*}                                          # > 1.2
PATCH_VERSION=$(echo "$SEMANTIC_VERSION" | sed "s/$MAJOR_AND_MINOR_VERSION.//")         # > 3

NEW_PATCH_VERSION=$(($PATCH_VERSION+1))                                                 # > 4
COMMIT_SHA=$(git rev-parse --short=12 HEAD)                                             # eks: 22ea0ff

VERSION="$SEMANTIC_VERSION-$COMMIT_SHA"                                                 # > 1.2.3-22ea0ff
NEW_SNAPSHOT_VERSION="$MAJOR_AND_MINOR_VERSION.$NEW_PATCH_VERSION-SNAPSHOT"             # > 1.2.4-SNAPSHOT

echo "semantic version: $SEMANTIC_VERSION" > .semantic-versio                           # > 1.2.3
echo "release version : $VERSION" > .release-version                                    # > v1.2.3-22ea0ff
echo "commit sha      : $COMMIT_SHA" > .commit-sha                                      # > 22ea0ff
echo "new snap version: $NEW_SNAPSHOT_VERSION" > .new-snapshot-version                  # > 1.2.4-SNAPSHOT

# Update to semantic version with commit hash
echo "Setting release version: $VERSION"
mvn -B versions:set -DnewVersion="$VERSION"
