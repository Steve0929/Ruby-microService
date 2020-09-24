#1. docker build -t msruby .
#2. docker run --publish 3000:3000 --detach --name msr msruby 
FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler -v '~> 2.1.4'
RUN gem update bundler
ENV BUNDLER_VERSION=2.1.4

RUN bundle install
ADD . /app


# Set "rails server -b 0.0.0.0" as the command to
# run when this container starts.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD rails server -b 0.0.0.0
