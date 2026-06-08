#!/bin/bash
# Tarefa 06 - Gerenciamento de processos do ambiente Linux do coworking.

listar_processos() {
    echo "[INFO] Listando processos ativos:"
    ps aux --sort=-%mem | head -n 15
}

buscar_processo() {
    local NOME="$1"
    if [ -z "$NOME" ]; then
        echo "[ERRO] Informe o nome do processo. Exemplo: ./06_processos.sh buscar apache"
        return 1
    fi
    echo "[INFO] Buscando processo: $NOME"
    ps aux | grep -i "$NOME" | grep -v grep || echo "[ALERTA] Nenhum processo encontrado com o nome $NOME"
}

matar_processo() {
    local PID="$1"
    if [ -z "$PID" ]; then
        echo "[ERRO] PID não informado. Exemplo: ./06_processos.sh matar 1234"
        return 1
    fi

    if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
        echo "[ERRO] PID inválido. Informe apenas números."
        return 1
    fi

    if [ "$PID" -eq 1 ]; then
        echo "[SEGURANÇA] O PID 1 não será encerrado para não derrubar o container."
        return 1
    fi

    echo "[ALERTA] Encerrando processo PID $PID"
    kill "$PID" && echo "[OK] Processo $PID encerrado." || echo "[ERRO] Não foi possível encerrar o processo $PID."
}

case "$1" in
    listar) listar_processos ;;
    buscar) buscar_processo "$2" ;;
    matar) matar_processo "$2" ;;
    *)
        echo "Uso: $0 {listar|buscar <nome>|matar <pid>}"
        exit 1
        ;;
esac
