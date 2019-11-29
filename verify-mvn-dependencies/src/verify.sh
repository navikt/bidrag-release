#!/bin/bash
mvn -B dependency:tree | tee .dependency.tree

DEPENNDENCIES="$(cat .dependency.tree | grep -e '|' -e +)"
COUNT="$(echo $DEPENNDENCIES | grep -c SNAPSHOT)"

echo "Found $COUNT SNAPSHOT dependencies"

if [ "$COUNT" -gt 0 ]
  then
    >&2 echo ERROR: No SNAPSHOT dependencies allowed
    exit 1;
fi
