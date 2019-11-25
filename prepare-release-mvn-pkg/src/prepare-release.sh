#!/bin/bash
set -e

echo "$(git rev-parse --short=12 HEAD)" > .commit_sha

cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  /v/' | sed 's/-SNAPSHOT//' | sed 's;[</>];;g' > .tagged_release

mvn -B release:update-versions

cat pom.xml | grep version | grep SNAPSHOT | \
  sed 's/version//g' | sed 's/  /Bumped to new version: /' | sed 's:[</>]::g'
