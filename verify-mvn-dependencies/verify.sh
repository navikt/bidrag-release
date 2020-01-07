#!/bin/bash
set -e

mvn -B dependency:tree | tee .dependency-tree

ARTIFACT=$(echo "$GITHUB_REPOSITORY" | sed 's/navikt\///')
DEPENDENCIES=$(cat .dependency-tree | grep "\[INFO]")
REMOVED_ARTIFACT=$(echo "$DEPENDENCIES" | grep -v "$ARTIFACT")
COUNT=$(echo "$REMOVED_ARTIFACT" | grep -c SNAPSHOT)

echo "Found $COUNT SNAPSHOT dependencies"

if [ "$COUNT" -gt 0 ]
  then
    >&2 echo "::error No SNAPSHOT dependencies allowed"
    exit 1;
fi
