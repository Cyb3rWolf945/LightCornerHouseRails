# Use Ruby 3.2.2 oficial
FROM ruby:3.2.2

# Define diretório de trabalho
WORKDIR /app

# Instala dependências do sistema para compilar gems nativas
RUN apt-get update -qq && \
    apt-get install -y \
        build-essential \        # compiladores C/C++
        libpq-dev \              # PostgreSQL gem
        libxml2-dev libxslt1-dev \ # Nokogiri e similares
        zlib1g-dev \             # compressão
        libffi-dev \             # gems nativas dependentes de FFI
        libgmp-dev \             # gems numéricas
        nodejs \                 # runtime JS para Rails
        yarn \                   # assets
        postgresql-client \      # cliente Postgres
        curl && \
    rm -rf /var/lib/apt/lists/*

# Copia Gemfile + Gemfile.lock primeiro (para cache)
COPY Gemfile Gemfile.lock ./

# Instala todas as gems
RUN bundle install

# Copia o restante da aplicação
COPY . .

# Remove PID antigo (previne problemas ao iniciar Rails)
RUN rm -f tmp/pids/server.pid

# Define ambiente de produção
ENV RAILS_ENV=production

# Pré-compila assets
RUN bundle exec rails assets:precompile

# Expõe porta padrão do Rails
EXPOSE 3000

# Comando padrão para iniciar Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
