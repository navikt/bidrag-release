const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute verify bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

    const encoding = {encoding: 'utf-8'};
    let filepath = `${process.env.GITHUB_WORKSPACE}/.tagged_release`;

    fs.readFile(filepath, encoding, function(err,data){
      if (!err) {
        core.info('read tagged release: ' + data);
        core.setOutput("tagged-release", data);
      } else {
        console.log(err);
      }
    });

    filepath = `${process.env.GITHUB_WORKSPACE}/.commit_sha`;

    fs.readFile(filepath, encoding, function(err,data){
      if (!err) {
        core.info('read commit sha: ' + data);
        core.setOutput("commit-sha", data);
      } else {
        console.log(err);
      }
    });
  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
