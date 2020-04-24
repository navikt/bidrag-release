const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    const isReleaseCandidate = core.getInput('is_release_candidate');
    const newSnapshotVersion = core.getInput('new_snapshot_version');
    const releaseVersion = core.getInput('release_version');
    const isCommitTag = core.getInput('is_commit_tag');

    // Execute release bash script
    await exec.exec(
        `bash ${__dirname}/../release.sh ${isReleaseCandidate} ${newSnapshotVersion} ${releaseVersion} ${isCommitTag}`
    );

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
