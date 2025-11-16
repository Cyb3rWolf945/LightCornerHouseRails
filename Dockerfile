FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfile first for caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p tmp/pids

EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
