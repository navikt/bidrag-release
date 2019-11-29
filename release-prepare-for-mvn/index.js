const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
