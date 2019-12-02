const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {

    core.debug(`filepath: ${__dirname}`);

    // Execute verify-deploy bash script
    await exec.exec(`${__dirname}/verify-deploy.sh`);

  } catch
      (error) {
    core.setFailed(error.message);
  }
}

run();
