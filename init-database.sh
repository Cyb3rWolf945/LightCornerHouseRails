#!/bin/bash
set -e

# Script para inicializar a base de dados apenas se necessário

echo "Verificando se a base de dados precisa ser inicializada..."

# Aguardar PostgreSQL estar pronto
until pg_isready -U postgres; do
  echo "Aguardando PostgreSQL..."
  sleep 2
done

# Verificar se a tabela 'fotos' existe e tem dados
TABLE_EXISTS=$(psql -U postgres -d myapp_development -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'fotos');" | tr -d ' ')

if [ "$TABLE_EXISTS" = "t" ]; then
    # Verificar se a tabela tem dados
    ROW_COUNT=$(psql -U postgres -d myapp_development -t -c "SELECT COUNT(*) FROM fotos;" | tr -d ' ')
    
    if [ "$ROW_COUNT" -eq "0" ]; then
        echo "Tabela 'fotos' existe mas está vazia. Carregando dados..."
        psql -U postgres -d myapp_development -f /tmp/data.sql
        echo "Dados carregados com sucesso!"
    else
        echo "Tabela 'fotos' já contém $ROW_COUNT registros. Nada a fazer."
    fi
else
    echo "Tabela 'fotos' não existe. Criando estrutura e carregando dados..."
    # Executar o SQL que criará a tabela e inserirá os dados
    psql -U postgres -d myapp_development -f /tmp/data.sql
    echo "Estrutura e dados criados com sucesso!"
fi

echo "Inicialização da base de dados concluída."
