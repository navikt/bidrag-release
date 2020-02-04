#!/bin/bash
set -e

if [ ! -z "$INPUT_SRC_FOLDER" ]
then
  cd "$INPUT_SRC_FOLDER"
fi

echo "Working directory"
pwd

# example, current version: 1.2.3-SNAPSHOT

# - fetch 1.2.3 of 1.2.3-SNAPSHOT version tag in pom.xml
RELEASE_VERSION=$(cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's/-SNAPSHOT//' | sed 's;[</>];;g')

# - writes release version (1.2.3) to file for INPUT_RELEASE_VERSION_FILE_NAME
echo "$RELEASE_VERSION" > "$INPUT_RELEASE_VERSION_FILE_NAME"

# updates to version 1.2.4-SNAPSHOT
mvn -B release:update-versions

# writes new snapshot version (1.2.4-SNAPSHOT) to file INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME
cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's;[</>];;g' > "$INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME"

# Update to new release version with commit hash
echo "Setting release version: $RELEASE_VERSION"
mvn -B versions:set -DnewVersion="$RELEASE_VERSION"
