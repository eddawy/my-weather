bundle check || bundle install

if [ -e ~/.should_create ]; then
  rm ~/.should_create
  bin/rake db:create db:schema:load db:seed
fi

bundle exec rake db:migrate
bundle exec rake assets:precompile

bundle exec rails s -p 3000 -b 0.0.0.0
