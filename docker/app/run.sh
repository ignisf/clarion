#!/bin/sh

# Install dependencies
bundle install

# DB migrations
./bin/rails db:create
./bin/rails db:migrate
./bin/rails db:seed

# Remove leftover PID file from non-clean exit
rm tmp/pids/server.pid
./bin/rails server --binding=0.0.0.0