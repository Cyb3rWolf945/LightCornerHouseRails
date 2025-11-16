FROM ruby:3.2.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nodejs \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy Gemfile
COPY Gemfile Gemfile.lock ./

# Install gems - approach without Gemfile.lock if problematic
RUN if [ -f Gemfile.lock ]; then \
        bundle install; \
    else \
        bundle install && bundle lock; \
    fi

# Copy application
COPY . .

# Create necessary directories
RUN mkdir -p tmp/pids

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
