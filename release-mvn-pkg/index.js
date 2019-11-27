const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    let newSnapshotVersion = core.getInput(
        "new-snapshot-version", {required: true}
    );

    let newSnapshotFile = `${process.env.GITHUB_WORKSPACE}/.new-snapshot-version`;

    try {
      fs.writeFileSync(newSnapshotFile, newSnapshotVersion);
    } catch (err) {
      core.setFailed(err.message)
    }

    // Execute release bash script
    await exec.exec(`${__dirname}/src/release.sh`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
