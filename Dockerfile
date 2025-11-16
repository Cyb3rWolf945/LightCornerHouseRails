FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfile first for better caching
COPY Gemfile Gemfile.lock ./

# Debug: show what files are copied
RUN echo "=== FILES IN /app ===" && \
    ls -la && \
    echo "=== GEMFILE CONTENT ===" && \
    cat Gemfile && \
    echo "=== INSTALLING GEMS ==="

# Install gems with better error handling
RUN bundle install --verbose || \
    (echo "=== BUNDLE INSTALL FAILED ===" && \
     cat Gemfile.lock && \
     exit 1)

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p tmp/pids

EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
