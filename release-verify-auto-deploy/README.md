# bidrag-actions/release-verify-auto-deploy

This action will verify if an auto-deploy of a release can be done by
checking if the changelog for this artifact has been updated with the
version for this release.

Requires a github runner with maven and a github artifact with a
versioning system used by `release-prepare-for-mvm`

Requires that the file `.semantic-release-version` exists, ie. must be
written to the filesystem by a previous action. The only input required
is the static name of the file where the changelog is present, see
`action.yml`.
