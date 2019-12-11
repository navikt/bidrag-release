#!/bin/bash
set -e

# example, current version: 1.2.3-SNAPSHOT

# - fetch 1.2.3 of 1.2.3-SNAPSHOT version tag in pom.xml
RELEASE_VERSION=$(cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's/-SNAPSHOT//' | sed 's;[</>];;g')

# - writes release version (1.2.3) to file for INPUT_RELEASE_VERSION_FILE_NAME
echo "$RELEASE_VERSION" > "$INPUT_RELEASE_VERSION_FILE_NAME"

# updates to version 1.2.4-SNAPSHOT
mvn -B release:update-versions

# writes new snapshot version (1.2.4-SNNAPSHOT) to file INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME
cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's;[</>];;g' > "$INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME"

# fetch git commit sha to COMMIT_SHA, ex: 22ea0ff
COMMIT_SHA=$(git rev-parse --short=12 HEAD)

# creates RELEASE_VERSION_WITH_SHA
RELEASE_VERSION_WITH_SHA="$RELEASE_VERSION-$COMMIT_SHA"

# Update to new release version with commit hash
echo "Setting release version: $RELEASE_VERSION_WITH_SHA"
mvn -B versions:set -DnewVersion="$RELEASE_VERSION_WITH_SHA"
