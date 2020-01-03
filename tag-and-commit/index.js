const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {

    setAuthorInformation();

    // Execute tag bash script
    await exec.exec(`${__dirname}/git.sh`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

function setAuthorInformation() {
  const eventPath = process.env.GITHUB_EVENT_PATH;

  if (eventPath) {
    core.info(eventPath);

    const { author } = require(eventPath).head_commit;

    process.env.INPUT_AUTHOR_NAME = author.name;
    process.env.INPUT_AUTHOR_EMAIL = author.email;

  } else {
    core.warning('No event path available, unable to fetch author info.');

    process.env.INPUT_AUTHOR_NAME = 'Tag & Commit Action';
    process.env.INPUT_AUTHOR_EMAIL = 'bidrag-actions@github.com';
  }

  core.info(`Using '${process.env.AUTHOR_NAME} <${process.env.AUTHOR_EMAIL}>' as author.`);
}

// noinspection JSIgnoredPromiseFromCall
run();
