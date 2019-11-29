# bidrag-actions/prepare-release-for-mvn

This action will prepare a maven artifact to be released. It will get the
release version from the expected SNAPSHOT version of the project. The
SNAPSHOT-version will be bumped, ie. the pom.xml will be modified.

Requires a github runner with maven and a github artifact being built
with maven and runs on an environment which support bash-scripts.

No inputs are required but all  the action will outputs will be written
to the filesystem where the build is executing. The following files will
be produces:
- .release-version,
- .semantic-release-version,
- .new-snapshot-version
- .commit-sha.
