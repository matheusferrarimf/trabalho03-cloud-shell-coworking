#!/bin/bash
# Menu principal - integra as rotinas operacionais do Trabalho 03.

SCRIPTS_DIR="/app/scripts"

exibir_cabecalho() {
    clear
    echo "Criado por: Matheus Ferrari dos Santos"
    echo "Instituição: Unidavi"
    echo "Tema: Sistema de Gestão para um Pequeno Coworking"
    echo "===== MENU DEVOPS CLOUD ====="
}

executar_script() {
    local SCRIPT="$1"
    echo ""
    echo "[INFO] Executando $SCRIPT..."
    bash "$SCRIPTS_DIR/$SCRIPT"
    echo ""
    read -p "Pressione ENTER para voltar ao menu..." _
}

menu_principal() {
    while true; do
        exibir_cabecalho
        echo "1 - Atualizar sistema"
        echo "2 - Instalar Apache"
        echo "3 - Criar estrutura do projeto"
        echo "4 - Realizar backup"
        echo "5 - Fazer deploy"
        echo "6 - Ver processos"
        echo "7 - Monitorar sistema"
        echo "8 - Configurar usuários e permissões"
        echo "9 - Gerar relatório"
        echo "0 - Sair"
        echo ""
        read -p "Escolha uma opção: " OPCAO

        case "$OPCAO" in
            1) executar_script "01_update.sh" ;;
            2) executar_script "02_apache.sh" ;;
            3) executar_script "03_estrutura.sh" ;;
            4) executar_script "04_backup.sh" ;;
            5) executar_script "05_deploy.sh" ;;
            6)
                echo "1 - Listar processos"
                echo "2 - Buscar processo por nome"
                echo "3 - Matar processo por PID"
                read -p "Escolha: " SUB
                case "$SUB" in
                    1) bash "$SCRIPTS_DIR/06_processos.sh" listar ;;
                    2) read -p "Nome do processo: " NOME; bash "$SCRIPTS_DIR/06_processos.sh" buscar "$NOME" ;;
                    3) read -p "PID: " PID; bash "$SCRIPTS_DIR/06_processos.sh" matar "$PID" ;;
                    *) echo "Opção inválida" ;;
                esac
                read -p "Pressione ENTER para voltar ao menu..." _
                ;;
            7) executar_script "07_monitoramento.sh" ;;
            8) executar_script "08_usuarios_permissoes.sh" ;;
            9) executar_script "09_relatorio.sh" ;;
            0) echo "Saindo..."; exit 0 ;;
            *) echo "Opção inválida"; sleep 1 ;;
        esac
    done
}

menu_principal
