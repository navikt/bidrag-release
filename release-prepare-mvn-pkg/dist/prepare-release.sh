#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet:
# 1) Henter gjeldene snapshot versjon for å finne release versjon som også skrives til fil
# 2) Bruker maven til å finne ny snapshot versjon som skrives til fil
# 3) Bruker maven til å oppdatere pom med release versjon som er funnet
#
############################################

if [ ! -z "$INPUT_SRC_FOLDER" ]
then
  cd "$INPUT_SRC_FOLDER"
fi

echo "Working directory"
pwd

# example, current version: 1.2.3-SNAPSHOT

# - fetch 1.2.3 of 1.2.3-SNAPSHOT version tag in pom.xml
RELEASE_VERSION=$(cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's/-SNAPSHOT//' | sed 's;[</>];;g' | xargs)

if [ -z "$RELEASE_VERSION" ]; then
  >&2 echo "::error No snapshot version is found. Unable to determine release version"
  exit 1;
fi

# - writes release version (1.2.3) to file for INPUT_RELEASE_VERSION_FILE_NAME
echo "$RELEASE_VERSION" > "$INPUT_RELEASE_VERSION_FILE_NAME"

# updates to version 1.2.4-SNAPSHOT
mvn -B -e release:update-versions

# writes new snapshot version (1.2.4-SNAPSHOT) to file INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME
cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  //' | sed 's;[</>];;g' > "$INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME"

echo "Setting release version        : $RELEASE_VERSION"
echo "Preserving new snapshot version: $(cat "$INPUT_NEW_SNAPSHOT_VERSION_FILE_NAME")"

# Update to new release version with commit hash
mvn -B -e versions:set -DnewVersion="$RELEASE_VERSION"
