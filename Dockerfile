FROM ruby:3.2.2

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      libxml2-dev \
      libxslt1-dev \
      nodejs \
      postgresql-client \
      yarn \
      curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfile & Gemfile.lock first (for layer caching)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy application code
COPY . .

# Prevent Rails from failing due to leftover PID file
RUN rm -f tmp/pids/server.pid

# Precompile assets (RAILS_ENV must be set)
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]
