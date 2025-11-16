#!/bin/bash
set -e

# Espera até que o serviço de banco de dados 'db' esteja pronto (necessita do 'psql' instalado)
until PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -U "$DATABASE_USER" -c '\q'; do
  >&2 echo "Postgres não está pronto - aguardando 1 segundo..."
  sleep 1
done

>&2 echo "Postgres está pronto. Iniciando a aplicação Rails."

# Remove o arquivo PID do servidor Rails se ele existir
rm -f /app/tmp/pids/server.pid

# Executa o comando principal do container
exec "$@"