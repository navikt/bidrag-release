const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

    let filepath = `${process.env.GITHUB_WORKSPACE}/.tagged_release`;

    prepareRelease(filepath).then(
        value => {
          core.info('the tagged release: ' + value);
          core.setOutput("tagged-release", value);
        }
    );

    filepath = `${process.env.GITHUB_WORKSPACE}/.commit_sha`;

    prepareRelease(filepath).then(
        value => {
          core.info('the commit sha: ' + value);
          core.setOutput("commit-sha", value);
        }
    );

  } catch (error) {
    core.setFailed(error.message);
  }
}

function prepareRelease(filepath) {
  const encoding = {encoding: 'utf-8'};

  return new Promise((resolve, reject) => {
        fs.readFile(filepath, encoding, function (error, data) {
          if (error) {
            console.log(error);
            reject(error)
          } else {
            resolve(data)
          }
        })
      }
  );
}

// noinspection JSIgnoredPromiseFromCall
run();
