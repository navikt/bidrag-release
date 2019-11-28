const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/prepare-release.sh`);

    readPrepareRelease(".semantic-version", "semantic_version");
    readPrepareRelease(".release-version", "release_version");
    readPrepareRelease(".commit-sha", "commit_sha");
    readPrepareRelease(".new-snapshot-version", "new_snapshot_version");

  } catch (error) {
    core.setFailed(error.message);
  }
}

function readPrepareRelease(filename, output) {
  let filepath = `${process.env.GITHUB_WORKSPACE}/${filename}`;

  prepareRelease(filepath).then(
      value => {
        core.info('the tagged release: ' + value);
        core.setOutput(output, value);
      }
  );
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
