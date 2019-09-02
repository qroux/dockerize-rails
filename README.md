# Dockerize rails app with postgresql database

1) create a basic rails app:

rails new project-name -T -d postgresql
create at least a model to test your application + seed file
rails db:create db:migrate db:seed

2) create a Dockerfile at root directory of the project

Dockerfile content:

FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /project-name
WORKDIR /project-name
COPY Gemfile /project-name/Gemfile
COPY Gemfile.lock /project-name/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /project-name

3) create a docker-compose.yml

docker-compose.yml content:

version: '3'
services:
 db:
  image: postgres
  volumes:
   - ./tmp/db:/var/lib/postgresql/data
 web:
  build: .
  command: bundle exec rails s -p 3000 -b '0.0.0.0'
  volumes:
   - .:/project-name
  ports:
   - "3000:3000"
  depends_on:
   - db


4) update your database.yml in config directory:

default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: project-name_development
  
 5) Build the docker image with docker-compose in the terminal
 
 docker-compose build

6) run the rails command inside the container with the terminal command

docker-compose run web rake db:create db:migrate db:seed

7)Run the container with this command:

docker-compose up

at this point, the application must be running on localhost:3000




 
 


