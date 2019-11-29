const core = require("@actions/core");
const exec = require("@actions/exec");
const fs = require("fs");

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

    writeFile(
        `${process.env.GITHUB_WORKSPACE}/changelog-file￿`, changelogFile
    ).then(
        result => core.debug(result)
    );

    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(`${__dirname}/src/verify-deploy.sh`);

  } catch
      (error) {
    core.setFailed(error.message);
  }
}

run();
