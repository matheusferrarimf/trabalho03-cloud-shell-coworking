#!/bin/bash
# Tarefa 08 - Criação de grupo, usuário e permissões para dados de reservas do coworking.

GRUPO="coworking_ops"
USUARIO="reserva_user"
DIR_RESERVAS="/app/coworking/reservas"
DIR_CONTRATOS="/app/coworking/contratos"
LOG_FILE="/app/logs/usuarios_permissoes.log"
mkdir -p /app/logs

configurar_usuarios_permissoes() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Configurando usuários e permissões do coworking" | tee -a "$LOG_FILE"

    if [ "$(id -u)" -ne 0 ]; then
        echo "[ERRO] Execute este script como root." | tee -a "$LOG_FILE"
        return 1
    fi

    getent group "$GRUPO" >/dev/null || groupadd "$GRUPO"
    id "$USUARIO" >/dev/null 2>&1 || useradd -r -g "$GRUPO" -d /app/coworking -s /usr/sbin/nologin "$USUARIO"

    mkdir -p "$DIR_RESERVAS" "$DIR_CONTRATOS"
    chown -R "$USUARIO:$GRUPO" "$DIR_RESERVAS" "$DIR_CONTRATOS"
    chmod 750 "$DIR_RESERVAS" "$DIR_CONTRATOS"

    echo "[OK] Grupo configurado: $GRUPO" | tee -a "$LOG_FILE"
    echo "[OK] Usuário configurado: $USUARIO" | tee -a "$LOG_FILE"
    echo "[OK] Permissões aplicadas sem uso de chmod 777" | tee -a "$LOG_FILE"
    ls -ld "$DIR_RESERVAS" "$DIR_CONTRATOS" | tee -a "$LOG_FILE"
}

configurar_usuarios_permissoes
