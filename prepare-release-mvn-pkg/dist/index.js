module.exports =
/******/ (function(modules, runtime) { // webpackBootstrap
/******/ 	"use strict";
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	__webpack_require__.ab = __dirname + "/";
/******/
/******/ 	// the startup function
/******/ 	function startup() {
/******/ 		// Load entry module and return exports
/******/ 		return __webpack_require__(622);
/******/ 	};
/******/
/******/ 	// run startup
/******/ 	return startup();
/******/ })
/************************************************************************/
/******/ ({

/***/ 176:
/***/ (function() {

eval("require")("@actions/exec");


/***/ }),

/***/ 622:
/***/ (function(__unusedmodule, __unusedexports, __webpack_require__) {

const core = __webpack_require__(968);
const exec = __webpack_require__(176);
const fs = __webpack_require__(747);
const process = __webpack_require__(765);

async function run() {
  try {
    core.debug(`filepath: ${__dirname}`);

    // Execute prepare-release bash script
    await exec.exec(__webpack_require__.ab + "prepare-release.sh");

    let filepath = `${process.env.GITHUB_WORKSPACE}/.tagged_release`;

    prepareRelease(filepath).then(
        value => {
          core.info('the tagged release: ' + value);
          core.setOutput("tagged-release", 'v' + value);
        }
    );

    filepath = `${process.env.GITHUB_WORKSPACE}/.commit_sha`;

    prepareRelease(filepath).then(
        value => {
          core.info('the commit sha: ' + value);
          core.setOutput("commit-sha", value);
        }
    );

    filepath = `${process.env.GITHUB_WORKSPACE}/.new_patch_version`;

    prepareRelease(filepath).then(
        value => {
          core.info('the new patch version: ' + value);
          core.setOutput("new-patch-version", value);
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


/***/ }),

/***/ 747:
/***/ (function(module) {

module.exports = require("fs");

/***/ }),

/***/ 765:
/***/ (function(module) {

module.exports = require("process");

/***/ }),

/***/ 968:
/***/ (function() {

eval("require")("@actions/core");


/***/ })

/******/ });