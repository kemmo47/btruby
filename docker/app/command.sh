rm -f tmp/pids/server.pid

bundle check || bundle install --binstubs=/foodlog

bundle exec rails db:prepare && bundle exec rails s -p 3000 -b 0.0.0.0