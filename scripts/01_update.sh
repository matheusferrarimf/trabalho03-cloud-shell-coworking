#!/bin/bash
# Tarefa 01 - Atualização do sistema para o ambiente do coworking.

LOG_FILE="/app/logs/update.log"
mkdir -p /app/logs

atualizar_sistema() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando atualização do sistema do Coworking Cloud" | tee -a "$LOG_FILE"

    if [ "$(id -u)" -ne 0 ]; then
        echo "[ERRO] Execute este script como root dentro do container." | tee -a "$LOG_FILE"
        return 1
    fi

    apt update && apt upgrade -y
    STATUS=$?

    if [ $STATUS -eq 0 ]; then
        echo "[OK] Sistema atualizado com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao atualizar o sistema." | tee -a "$LOG_FILE"
    fi

    return $STATUS
}

atualizar_sistema
