#!/bin/bash
set -e

mvn -B dependency:tree | tee .dependency.tree

COUNT="$(cat < .dependency.tree | grep -e '|' -e '+' | grep -c SNAPSHOT)"

if [ "$COUNT" -eq 1 ]
  then
    >&2 echo ERROR: Found a SNAPSHOT dependency
    exit 1;
elif [ "$COUNT" -gt 0 ]
  then
    >&2 echo "ERROR: Found $COUNT SNAPSHOT dependencies"
    exit 1;
fi
