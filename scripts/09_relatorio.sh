#!/bin/bash
# Tarefa 09 - Relatório operacional automatizado do ambiente do coworking.

RELATORIO="/app/logs/relatorio_execucao.txt"
PROJETO="Trabalho 03 - Linux, Shell Script e Cloud Computing"
TEMA="Sistema de Gestão para um Pequeno Coworking"
ALUNO="Matheus Ferrari dos Santos"

status_apache() {
    if pgrep apache2 >/dev/null 2>&1; then
        echo "Apache: em execução"
    else
        echo "Apache: parado ou não identificado"
    fi
}

gerar_relatorio() {
    mkdir -p /app/logs
    {
        echo "===== RELATÓRIO OPERACIONAL ====="
        echo "Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "Aluno: $ALUNO"
        echo "Projeto: $PROJETO"
        echo "Tema: $TEMA"
        echo ""
        echo "--- Espaço em disco ---"
        df -h
        echo ""
        echo "--- Uso dos diretórios principais ---"
        du -sh /app /app/coworking /app/source /app/backups /app/logs 2>/dev/null
        echo ""
        echo "--- Status do Apache ---"
        status_apache
        apache2 -v 2>/dev/null || echo "Apache não encontrado"
        echo ""
        echo "--- Últimos backups ---"
        ls -lht /app/backups 2>/dev/null | head -n 10
        echo ""
        echo "--- Últimos logs ---"
        ls -lht /app/logs 2>/dev/null | head -n 10
        echo ""
        echo "--- Arquivos publicados no Apache ---"
        find /var/www/html -maxdepth 2 -type f 2>/dev/null | sort
        echo ""
        echo "--- Usuários e permissões principais ---"
        getent group coworking_ops || true
        id reserva_user 2>/dev/null || echo "Usuário reserva_user ainda não criado"
        ls -ld /app/coworking /app/coworking/reservas /app/coworking/contratos 2>/dev/null
        echo "=================================="
    } > "$RELATORIO"

    echo "[OK] Relatório gerado em $RELATORIO"
    cat "$RELATORIO"
}

gerar_relatorio
