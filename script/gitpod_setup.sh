#!/bin/bash -ex

source ~/.nvm/nvm.sh
nvm install lts/dubnium
nvm alias default lts/dubnium

bundle install
yarn install --pure-lockfile

for config in amazon_s3 database delayed_jobs domain file_store outgoing_mail security external_migration; do
    cp -v config/$config.yml.example config/$config.yml
done

bundle exec rake canvas:compile_assets
createdb canvas_development
export CANVAS_LMS_ADMIN_EMAIL=admin@example.com
export CANVAS_LMS_ADMIN_PASSWORD=password
export CANVAS_LMS_ACCOUNT_NAME=Test
export CANVAS_LMS_STATS_COLLECTION=opt_out
bundle exec rails db:initial_setup
