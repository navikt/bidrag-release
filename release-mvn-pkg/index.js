const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute release bash script
    await exec.exec(`${__dirname}/src/release.sh`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
