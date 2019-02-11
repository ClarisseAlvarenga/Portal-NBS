#!/bin/sh

rake assets:precompile && bundle exec rake db:migrate && bundle exec rake db:seed && bin/delayed_job start && exec bundle exec passenger start --port 3000 --environment $RAILS_ENV