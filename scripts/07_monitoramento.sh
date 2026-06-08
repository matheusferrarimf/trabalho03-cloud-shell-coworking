#!/bin/bash
# Tarefa 07 - Monitoramento de CPU, memória, disco e Apache no ambiente do coworking.

LOG_FILE="/app/logs/monitoramento.log"
mkdir -p /app/logs

coletar_cpu() {
    CPU_USO=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}' | cut -d. -f1)
    CPU_USO=${CPU_USO:-0}
    echo "CPU: ${CPU_USO}%" | tee -a "$LOG_FILE"
    if [ "$CPU_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de CPU acima de 80%" | tee -a "$LOG_FILE"
    else
        echo "[OK] CPU dentro do esperado" | tee -a "$LOG_FILE"
    fi
}

coletar_memoria() {
    MEM_USO=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
    echo "Memória RAM: ${MEM_USO}%" | tee -a "$LOG_FILE"
    if [ "$MEM_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de memória acima de 80%" | tee -a "$LOG_FILE"
    else
        echo "[OK] Memória dentro do esperado" | tee -a "$LOG_FILE"
    fi
}

coletar_disco() {
    DISCO_USO=$(df / | awk 'NR==2 {gsub("%", "", $5); print $5}')
    echo "Disco raiz: ${DISCO_USO}%" | tee -a "$LOG_FILE"
    if [ "$DISCO_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de disco acima de 80%" | tee -a "$LOG_FILE"
    else
        echo "[OK] Disco dentro do esperado" | tee -a "$LOG_FILE"
    fi
}

verificar_apache_monitoramento() {
    if pgrep apache2 >/dev/null 2>&1; then
        echo "[OK] Apache em execução" | tee -a "$LOG_FILE"
    else
        echo "[ALERTA] Apache não está em execução" | tee -a "$LOG_FILE"
    fi
}

monitorar_sistema() {
    echo "===== MONITORAMENTO COWORKING CLOUD - $(date '+%Y-%m-%d %H:%M:%S') =====" | tee -a "$LOG_FILE"
    coletar_cpu
    coletar_memoria
    coletar_disco
    verificar_apache_monitoramento
    echo "" | tee -a "$LOG_FILE"
}

monitorar_sistema
