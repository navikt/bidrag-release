const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");
const process = require("process");

const writeSemanticVersion = (file, data) => {
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
    let semanticVersion = core.getInput("semantic-version", {required: true});
    let writePath = `${process.env.GITHUB_WORKSPACE}/${filename}/.semantic-version￿`;

    writeSemanticVersion(writePath, semanticVersion).then(
        result => core.debug(result)
    );

    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/verify-version.sh`);

    let readPath = `${process.env.GITHUB_WORKSPACE}/.is-release-candidate`;

    readIsReleaseCandidate(readPath).then(
        value => {
          core.info('the is release candidate: ' + value);
          core.setOutput("is-release-candidate", value);
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
