#!/bin/bash
set -e

git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git config --global user.email "$AUTHOR_EMAIL"
git config --global user.name "$AUTHOR_NAME"

if [ -f $INPUT_TAG_FILE ]
then
  TAG_CONTENT=$(cat $INPUT_TAG_FILE)
  echo "Tagging new version with: $TAG_CONTENT"

  INPUT_MESSAGE=$(echo $INPUT_MESSAGE | sed "s/{}/$TAG_CONTENT/")

  git tag -a "$TAG_CONTENT" -m "$INPUT_MESSAGE"
  git push origin "$TAG_CONTENT"
fi

if ! git diff --quiet
then
  echo "commiting changes with message: $INPUT_MESSAGE"

  git add "$INPUT_PATTERN"
  git commit -m "$INPUT_MESSAGE"
  git push
fi
