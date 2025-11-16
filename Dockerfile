FROM ruby:3.2.2

WORKDIR /app

# Instala dependências do sistema (tudo em uma única instrução RUN)
RUN apt-get update -qq && \
    apt-get install -y \
        build-essential \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        nodejs \
        yarn \
        postgresql-client \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Copia Gemfile e Gemfile.lock primeiro (para cache)
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle install

# Copia todo o restante da aplicação
COPY . .

# Remove PID antigo
RUN rm -f tmp/pids/server.pid

# Precompila assets
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
