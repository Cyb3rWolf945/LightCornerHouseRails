FROM ruby:3.2.3

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    postgresql-client \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar Yarn
RUN npm install -g yarn

# Criar diretório da aplicação
WORKDIR /app

# Expor porta 3000
EXPOSE 3000

# Comando padrão (será sobrescrito pelo docker-compose)
CMD ["bash"]