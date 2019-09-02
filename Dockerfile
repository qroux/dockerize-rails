FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /dockerize-rails
WORKDIR /dockerize-rails
COPY Gemfile /dockerize-rails/Gemfile
COPY Gemfile.lock /dockerize-rails/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /dockerize-rails
