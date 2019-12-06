const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/prepare-release.sh`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
