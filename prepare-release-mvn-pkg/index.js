const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute verify bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

    core.setOutput("tagged-release", fs.readFile(`${__dirname}/.tagged_release`));
    core.setOutput("commit-sha", fs.readFile(`${__dirname}/.commit_sha`));
  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
