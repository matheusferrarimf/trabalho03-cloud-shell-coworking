#!/bin/bash
# Tarefa 02 - Instalação e validação do Apache para publicar o sistema de coworking.

LOG_FILE="/app/logs/apache.log"
mkdir -p /app/logs

instalar_apache() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Instalando/validando Apache" | tee -a "$LOG_FILE"

    if [ "$(id -u)" -ne 0 ]; then
        echo "[ERRO] Execute este script como root dentro do container." | tee -a "$LOG_FILE"
        return 1
    fi

    apt update && apt install -y apache2
}

verificar_apache() {
    if command -v apache2 >/dev/null 2>&1; then
        echo "[OK] Apache está instalado." | tee -a "$LOG_FILE"
        apachectl -k start >/dev/null 2>&1 || true
        if pgrep apache2 >/dev/null 2>&1; then
            echo "[OK] Apache está em execução." | tee -a "$LOG_FILE"
        else
            echo "[ALERTA] Apache instalado, mas não foi possível confirmar execução." | tee -a "$LOG_FILE"
        fi
    else
        echo "[ERRO] Apache não encontrado." | tee -a "$LOG_FILE"
        return 1
    fi
}

versao_apache() {
    echo "Versão do Apache:" | tee -a "$LOG_FILE"
    apache2 -v | tee -a "$LOG_FILE"
}

instalar_apache && verificar_apache && versao_apache
