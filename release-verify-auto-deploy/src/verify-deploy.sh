#!/bin/bash
CHANGELOG_FILE="$(cat .changelog_file)"                                       # the name of the changelog file to read
SEMANTIC_RELEASE_VERSION="$(cat .semantic-release-version)"                   # the semantic release version to deploy
RELEASE_TABLE="$(cat "$CHANGELOG_FILE" | grep '|' )"                          # the release table in the changelog file
COUNT="$(echo "$RELEASE_TABLE" | grep -c "$SEMANTIC_RELEASE_VERSION")"        # count all mentions of 'SEMANTIC_RELEASE_VERSION' in the RELEASE_TABLE

echo "echo Found $COUNT mentioning(s) of $SEMANTIC_RELEASE_VERSION in $CHANGELOG_FILE."

if [ $COUNT -lt 1 ]
  then
    echo This artifact is not eligable for auto deployment
    echo false > .is_release_candidate
    exit 0;
fi

echo This artifact is eligable for auto deployment
echo true > .is_release_candidate
