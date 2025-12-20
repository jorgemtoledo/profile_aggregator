#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails-app/tmp/pids/server.pid

#roda o db create e db migrate
bundle exec rails db:migrate

exec "$@"