#!/bin/bash
set -e

echo "bundle install..."
bundle check || bundle install --jobs 4

yarn install

exec ./bin/bundle exec rails tailwindcss:watch
