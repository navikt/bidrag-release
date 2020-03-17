#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet:
# 1) Går til angitt mappe (hvis angitt) for utføring av script
# 2) Hvis det ikke er en "release candidate", så avsluttes scriptet uten feil
# 3) Når det er en "release candidate", så kjøres mvn deploy uten testing
# 4) Når det er en "release candidate", så oppdates "maven project object model" (pom.xml) med ny SNAPSHOT versjon
#
############################################


if [ ! -z "$INPUT_SRC_FOLDER" ]
then
  cd "$INPUT_SRC_FOLDER"
fi

echo "Working directory"
pwd

if [ "$INPUT_IS_RELEASE_CANDIDATE" != "true" ]
then
  echo "The artifact is not a release candidate..."
  exit 0;
fi

echo "Running release"
mvn -B --settings maven-settings.xml deploy -e -DskipTests -Dmaven.wagon.http.pool=false

# Update to new SNAPSHOT version
echo "Setting SNAPSHOT version: $INPUT_NEW_SNAPSHOT_VERSION"
mvn -B versions:set -DnewVersion="$INPUT_NEW_SNAPSHOT_VERSION"
