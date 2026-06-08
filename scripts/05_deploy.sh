#!/bin/bash
# Tarefa 05 - Deploy do site estático do Sistema de Gestão para Pequeno Coworking no Apache.

ORIGEM="/app/source"
DESTINO="/var/www/html"
LOG_FILE="/app/logs/deploy.log"
mkdir -p /app/logs

realizar_deploy() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando deploy do site do coworking" | tee -a "$LOG_FILE"

    if [ ! -d "$ORIGEM" ]; then
        echo "[ERRO] Pasta de origem $ORIGEM não encontrada." | tee -a "$LOG_FILE"
        return 1
    fi

    if [ "$(id -u)" -ne 0 ]; then
        echo "[ERRO] Execute este script como root para publicar em $DESTINO." | tee -a "$LOG_FILE"
        return 1
    fi

    rm -rf "${DESTINO:?}"/*
    cp -r "$ORIGEM"/* "$DESTINO"/
    apachectl -k graceful >/dev/null 2>&1 || apachectl -k start >/dev/null 2>&1 || true

    echo "[INFO] Arquivos publicados:" | tee -a "$LOG_FILE"
    find "$DESTINO" -maxdepth 2 -type f | sort | tee -a "$LOG_FILE"

    if [ -f "$DESTINO/index.html" ]; then
        echo "[OK] Deploy realizado com sucesso. Acesse http://localhost:8080" | tee -a "$LOG_FILE"
    else
        echo "[ERRO] index.html não encontrado no destino." | tee -a "$LOG_FILE"
        return 1
    fi
}

realizar_deploy
