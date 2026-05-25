#!/bin/bash

# =========================================================
# Script de instalação do PostgreSQL + N8N
# Ubuntu/Debian
# Porque aparentemente humanos gostam de automatizar
# sistemas para depois quebrá-los em produção às 3h da manhã.
# =========================================================

set -e

echo "[+] Atualizando repositórios..."
sudo apt update

# ---------------------------------------------------------
# Instala PostgreSQL caso não exista
# ---------------------------------------------------------
if ! command -v psql >/dev/null 2>&1; then
    echo "[+] PostgreSQL não encontrado. Instalando..."
    sudo apt install -y postgresql postgresql-contrib

    echo "[+] Habilitando PostgreSQL..."
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
else
    echo "[=] PostgreSQL já instalado."
fi

# ---------------------------------------------------------
# Instala Node.js LTS caso não exista
# ---------------------------------------------------------
if ! command -v node >/dev/null 2>&1; then
    echo "[+] Node.js não encontrado. Instalando Node.js LTS..."

    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "[=] Node.js já instalado."
fi

# ---------------------------------------------------------
# Instala N8N caso não exista
# ---------------------------------------------------------
if ! command -v n8n >/dev/null 2>&1; then
    echo "[+] N8N não encontrado. Instalando..."
    sudo npm install -g n8n
else
    echo "[=] N8N já instalado."
fi

# ---------------------------------------------------------
# Verificações finais
# ---------------------------------------------------------
echo
echo "[+] Versões instaladas:"
echo "-----------------------------------"

if command -v psql >/dev/null 2>&1; then
    psql --version
fi

if command -v node >/dev/null 2>&1; then
    node --version
fi

if command -v npm >/dev/null 2>&1; then
    npm --version
fi

if command -v n8n >/dev/null 2>&1; then
    n8n --version
fi

echo "-----------------------------------"
echo "[+] Instalação concluída."

echo
echo "[+] Para iniciar o N8N manualmente:"
echo "n8n"

echo
echo "[+] Para acessar:"
echo "http://localhost:5678"

# Fim.
# A máquina obedeceu. Por enquanto.
