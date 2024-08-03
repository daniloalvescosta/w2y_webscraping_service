FROM ruby:3.2.2

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
COPY Gemfile* ./

RUN bundle install
COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
