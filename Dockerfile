FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-client nginx cron vim

ENV appdir /var/app
RUN mkdir -p $appdir
WORKDIR $appdir

ADD Gemfile $appdir/Gemfile
ADD Gemfile.lock $appdir/Gemfile.lock
RUN bundle install
ADD . $appdir

RUN touch ~/.should_create
ADD ./.docker/entrypoint.sh /etc/
ENTRYPOINT "/etc/entrypoint.sh"
