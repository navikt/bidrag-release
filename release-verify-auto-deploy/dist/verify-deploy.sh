#!/bin/bash

if [ ! -f "$RELEASE_VERSION_FILE" ]
  then
    >&2 "echo no $RELEASE_VERSION_FILE found!"
    exit 1;
fi

if [ ! -f "$CHANGELOG_FILE" ]
  then
    >&2 "echo no $CHANGELOG_FILE found!"
    exit 1;
fi

RELEASE_VERSION="$(cat "$RELEASE_VERSION_FILE")"                  # the release version to deploy
RELEASE_TABLE="$(cat "$CHANGELOG_FILE" | grep '|' )"              # the release table in the changelog file
COUNT="$(echo "$RELEASE_TABLE" | grep -c "$RELEASE_VERSION")"   # count all mentions of 'RELEASE_VERSION' in the 'RELEASE_TABLE' from the changelog

echo "echo Found $COUNT mentioning(s) of $RELEASE_VERSION in $CHANGELOG_FILE."

if [ "$COUNT" -lt 1 ]
  then
    echo This artifact is not eligable for auto deployment
    touch .is-not-release-candidate
    exit 0;
fi

echo This artifact is eligable for auto deployment
touch .is-release-candidate
