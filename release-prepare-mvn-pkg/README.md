# bidrag-actions/release-prepare-mvn-pkg

This action will prepare a maven artifact to be released. It will get the
release version from the expected SNAPSHOT version of the project. The
SNAPSHOT-version will be bumped, ie. the pom.xml will be modified.

Requires a github runner with maven and a github artifact being built
with maven and runs on an environment which support bash-scripts.

The name of the files (new snapshot version and release version) are
required and the outputs of the actions will be written to these files.

The following files will be produced, see inputs in `action.yml`:
- RELEASE_VERSION_FILE_NAME, for instance `.release-version`
- NEW_SNAPSHOT_VERSION_FILE_NAME, for instance, `.new-snapshot-version`
