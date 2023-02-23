#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

echo "bundle install..."
bundle check || bundle install --jobs 4

yarn install

exec ./bin/bundle exec rails s -b 0.0.0.0 -p 3000
