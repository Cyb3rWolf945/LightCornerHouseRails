FROM ruby:3.2.2

WORKDIR /app

# Dependências do sistema para gems nativas
RUN apt-get update -qq && \
    apt-get install -y \
        build-essential \
        libpq-dev \
        libxml2-dev libxslt1-dev \
        zlib1g-dev \
        nodejs \
        yarn \
        postgresql-client \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Gemfile + Gemfile.lock para cache
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle install

# Copia o restante da aplicação
COPY . .

# Remove PID antigo
RUN rm -f tmp/pids/server.pid

# Precompila assets
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
