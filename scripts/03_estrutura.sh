#!/bin/bash
# Tarefa 03 - Criação da estrutura temática para Sistema de Gestão de Pequeno Coworking.

BASE_DIR="/app/coworking"
LOG_FILE="/app/logs/estrutura.log"
mkdir -p /app/logs

criar_estrutura_coworking() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Preparando estrutura do Coworking Cloud" | tee -a "$LOG_FILE"

    if [ -d "$BASE_DIR" ]; then
        echo "[INFO] Estrutura antiga encontrada em $BASE_DIR" | tee -a "$LOG_FILE"
        rm -rf "${BASE_DIR:?}/salas" "${BASE_DIR:?}/reservas" "${BASE_DIR:?}/membros" "${BASE_DIR:?}/contratos" "${BASE_DIR:?}/financeiro" "${BASE_DIR:?}/publicacao"
    fi

    mkdir -p \
        "$BASE_DIR/salas" \
        "$BASE_DIR/reservas" \
        "$BASE_DIR/membros" \
        "$BASE_DIR/contratos" \
        "$BASE_DIR/financeiro" \
        "$BASE_DIR/publicacao" \
        "$BASE_DIR/logs" \
        "$BASE_DIR/backups"

    cat > "$BASE_DIR/salas/salas.csv" <<CSV
id,nome,capacidade,status
1,Sala Reunião Azul,8,disponivel
2,Estação Compartilhada,12,disponivel
3,Sala Privativa,4,reservada
CSV

    cat > "$BASE_DIR/reservas/reservas.csv" <<CSV
id,membro,sala,data,hora
1,Ana Souza,Sala Reunião Azul,$(date '+%Y-%m-%d'),09:00
CSV

    cat > "$BASE_DIR/membros/membros.csv" <<CSV
id,nome,plano
1,Ana Souza,Mensal
2,Carlos Lima,Diário
CSV

    echo "[OK] Estrutura criada em $BASE_DIR" | tee -a "$LOG_FILE"
    find "$BASE_DIR" -maxdepth 2 -type d | sort | tee -a "$LOG_FILE"
}

criar_estrutura_coworking
