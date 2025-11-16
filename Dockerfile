# Base image
FROM ruby:3.2.2

# Set working directory
WORKDIR /app

# Instala dependências do sistema necessárias para gems nativas e Rails
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \        # compiladores C/C++
      libpq-dev \              # para gem pg
      libxml2-dev libxslt1-dev \ # Nokogiri e similares
      zlib1g-dev \             # compressão
      nodejs \                 # JavaScript runtime
      yarn \                   # asset compilation
      postgresql-client \      # cliente PostgreSQL
      curl && \
    rm -rf /var/lib/apt/lists/*

# Copia Gemfile e Gemfile.lock primeiro (para caching de camada Docker)
COPY Gemfile Gemfile.lock ./

# Instala todas as gems
RUN bundle install

# Copia o restante da aplicação
COPY . .

# Remove PID antigo (previne problemas ao iniciar o Rails)
RUN rm -f tmp/pids/server.pid

# Precompila assets para produção
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

# Expondo a porta do Rails
EXPOSE 3000

# Comando padrão para iniciar o Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
