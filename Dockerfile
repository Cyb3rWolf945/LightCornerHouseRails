FROM ruby:3.2.2

WORKDIR /app

# Instala dependências do sistema para gems nativas
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libgmp-dev \
    nodejs \
    yarn \
    postgresql-client \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Copia Gemfile + Gemfile.lock primeiro (para cache)
COPY Gemfile Gemfile.lock ./

# Instala todas as gems
RUN bundle install

# Copia o restante da aplicação
COPY . .

# Remove PID antigo
RUN rm -f tmp/pids/server.pid

# Define ambiente de produção
ENV RAILS_ENV=production

# Pré-compila assets
RUN bundle exec rails assets:precompile

# Expõe porta do Rails
EXPOSE 3000

# Comando padrão para iniciar Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
