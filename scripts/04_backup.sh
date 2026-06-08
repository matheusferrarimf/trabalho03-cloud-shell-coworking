#!/bin/bash
# Tarefa 04 - Backup automatizado dos dados e do site do coworking.

ORIGEM="/app/coworking"
DESTINO="/app/backups"
LOG_FILE="/app/logs/backup.log"
DATA_HORA=$(date '+%Y-%m-%d_%H-%M')
ARQUIVO_BACKUP="$DESTINO/backup_coworking_${DATA_HORA}.tar.gz"
mkdir -p "$DESTINO" /app/logs

realizar_backup() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando backup do Coworking Cloud" | tee -a "$LOG_FILE"

    if [ ! -d "$ORIGEM" ]; then
        echo "[ALERTA] Diretório $ORIGEM não existe. Execute primeiro o script 03_estrutura.sh" | tee -a "$LOG_FILE"
        return 1
    fi

    tar -czf "$ARQUIVO_BACKUP" -C /app coworking source

    if [ -f "$ARQUIVO_BACKUP" ]; then
        echo "[OK] Backup criado: $ARQUIVO_BACKUP" | tee -a "$LOG_FILE"
        ls -lh "$ARQUIVO_BACKUP" | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Backup não foi criado." | tee -a "$LOG_FILE"
        return 1
    fi
}

realizar_backup
