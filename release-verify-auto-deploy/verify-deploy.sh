#!/bin/bash
set -e

if [ ! -f "$INPUT_RELEASE_VERSION_FILE" ]
  then
    >&2 echo ::error no $INPUT_RELEASE_VERSION_FILE found!
    exit 1;
fi

if [ ! -f "$INPUT_CHANGELOG_FILE" ]
  then
    >&2 "::error echo no $INPUT_CHANGELOG_FILE found!"
    exit 1;
fi

RELEASE_VERSION="$(cat "$INPUT_RELEASE_VERSION_FILE")"                # the release version to deploy
RELEASE_TABLE="$(cat "$INPUT_CHANGELOG_FILE" | grep '|' )"            # the release table in the changelog file
COUNT="$(echo "$RELEASE_TABLE" | grep -c "$RELEASE_VERSION" || true)" # count all mentions of 'RELEASE_VERSION' in the 'RELEASE_TABLE' from the changelog

echo "echo Found $COUNT mentioning(s) of $RELEASE_VERSION in $INPUT_CHANGELOG_FILE."

if [ "$COUNT" -lt 1 ]
  then
    echo This artifact is not eligable for auto deployment
    touch .is-not-release-candidate
    exit 0;
fi

echo This artifact is eligable for auto deployment
touch .is-release-candidate
