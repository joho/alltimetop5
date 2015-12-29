#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

git checkout deploy
git rebase --strategy=ours master

node_modules/.bin/webpack -p

git add -f public/build

git commit --amend --no-edit

git push heroku deploy:master

git checkout master
