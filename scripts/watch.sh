#!/usr/bin/env bash

set -e

# Kill all subprocesses when this script exits
trap "kill 0" EXIT

npx concurrently \
  --names=custom-elements:tsc,custom-elements:gulp \
  "npx tsc --project packages/custom-elements/tsconfig.json --watch --pretty --noEmitOnError"
  "chokidar 'packages/custom-elements/src/**/*.js' -c 'gulp -f packages/custom-elements/gulpfile.js'"

npx tsc --project packages/custom-elements/tsconfig.json \
  --watch --noEmitOnError &

npx chokidar "packages/custom-elements/src/**/*.js" -c \
  "gulp -f packages/custom-elements/gulpfile.js" &

npx chokidar "packages/html-imports/src/**/*.js" -c \
  "gulp -f packages/html-imports/gulpfile.js" &

npx chokidar "packages/shadycss/src/**/*.js" -c \
  "gulp -f packages/shadycss/gulpfile.js" &

npx chokidar "packages/shadydom/src/**/*.js" -c \
  "gulp -f packages/shadydom/gulpfile.js" &

npx chokidar "packages/template/src/**/*.js" -c \
  "gulp -f packages/template/gulpfile.js" &

npx chokidar "packages/url/src/**/*.js" -c \
  "gulp -f packages/url/gulpfile.js" &

npx tsc --project packages/webcomponentsjs/tsconfig.json \
  --watch --noEmitOnError &

npx chokidar "packages/webcomponentsjs/src/**/*.js" -c \
  "gulp -f packages/webcomponentsjs/gulpfile.js" &

wait
