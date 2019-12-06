const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/prepare-release.sh`);

    let releaseVersion;
    let releaseVersionFile = process.env.GITHUB_WORKSPACE + '/'
        + process.env.RELEASE_VERSION_FILE;

    fs.readFile(releaseVersionFile, function reading(err, data) {
      if (err) throw err;
      releaseVersion = data;
    });

    core.setOutput("release-version",)

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
