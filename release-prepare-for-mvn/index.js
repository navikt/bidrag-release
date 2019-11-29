const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

    readPrepareRelease(".semantic_release_version", "semantic-release-version");
    readPrepareRelease(".release_version", "release-version");
    readPrepareRelease(".commit_sha", "commit-sha");
    readPrepareRelease(".new_snapshot_version", "new-snapshot-version");

  } catch (error) {
    core.setFailed(error.message);
  }
}

function readPrepareRelease(filename, output) {
  let filepath = `${process.env.GITHUB_WORKSPACE}/${filename}`;

  readFilePromise(filepath).then(
      value => {
        core.info(filename + ': ' + value);
        core.setOutput(output, value);
      }
  );
}

function readFilePromise(filepath) {
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
