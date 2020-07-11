FROM ruby:2.7.1

WORKDIR /api

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
