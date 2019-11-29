# bidrag-actions/release-verify-auto-deploy

This action will verify if an auto-deploy of a release can be done by
checking if the changelog for this artifact has been updated with the
version for this release.

Requires a github runner with maven and a github artifact being released
with semantic release versioning.

Requires the semantic release version of this artifact, see `action.yml`.
