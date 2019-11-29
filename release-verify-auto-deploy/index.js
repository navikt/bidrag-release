const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

const writeFile = (file, data) => {
  return new Promise((resolve, reject) => {
    fs.writeFile(file, data, error => {
      if (error) {
        reject(error);
      }
      resolve("semantiv version created successfully!");
    });
  });
};

async function run() {
  try {
    let changelogFile = core.getInput("changelog-file", {required: true});
    let semanticReleaseVersion = core.getInput(
        "semantic-release-version", {required: true}
    );

    writeFile(
        `${process.env.GITHUB_WORKSPACE}/.release-version￿`, semanticReleaseVersion
    ).then(
        result => core.debug(result)
    );

    writeFile(
        `${process.env.GITHUB_WORKSPACE}/changelog-file￿`, changelogFile
    ).then(
        result => core.debug(result)
    );

    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/verify-deploy.sh`);

    let readPath = `${process.env.GITHUB_WORKSPACE}/.is_release_candidate`;

    readIsReleaseCandidate(readPath).then(
        value => {
          core.info('the is release candidate: ' + value);
          core.setOutput("is-release-candidate", Boolean(value));
        }
    );

  } catch
      (error) {
    core.setFailed(error.message);
  }
}

function readIsReleaseCandidate(filepath) {
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
