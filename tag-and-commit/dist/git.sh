#!/bin/bash
set -e

git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git

QUOTED_MESSAGE="'$INPUT_MESSAGE'"

if [ -f $INPUT_TAG_FILE ]
then
  TAG_CONTENT=$(cat $INPUT_TAG_FILE)
  echo "Tagging new version with: $TAG_CONTENT"

  QUOTED_MESSAGE=$(echo $QUOTED_MESSAGE | sed "s/{}/$TAG_CONTENT/")

  git tag -a "$TAG_CONTENT" -m "$INPUT_MESSAGE"

  git push origin "$TAG_CONTENT"
fi

if ! git diff --quiet
then
  git add "$INPUT_PATTERN"
  git commit -m "$QUOTED_MESSAGE"
  git push
fi
