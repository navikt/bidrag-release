const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    const newSnapshotVersion = core.getInput('new_snapshot_version');
    const releaseVersion = core.getInput('release_version');

    // Execute verify-deploy bash script
    await exec.exec(
        `bash ${__dirname}/verify-deploy.sh ${newSnapshotVersion} ${releaseVersion}`
    );

  } catch
      (error) {
    core.setFailed(error.message);
  }
}

run();
