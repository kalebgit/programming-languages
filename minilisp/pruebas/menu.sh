#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Directorio donde están los archivos fuente (../code desde pruebas)
SOURCE_DIR="$SCRIPT_DIR/../code"

# Banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                    MINILISP INTERPRETER                    ║"
    echo "║                   Sistema de Pruebas v1.0                  ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${YELLOW}Directorio de código: ${SOURCE_DIR}${NC}"
    echo -e "${YELLOW}Directorio de pruebas: ${SCRIPT_DIR}${NC}\n"
}

# Compilar el proyecto
compile_project() {
    echo -e "${YELLOW}Compilando proyecto...${NC}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Verificar que existan los archivos
    if [ ! -f "Lex.x" ]; then
        echo -e "${RED}✗ Error: No se encuentra Lex.x en $SOURCE_DIR${NC}"
        return 1
    fi
    
    if [ ! -f "Grammars.y" ]; then
        echo -e "${RED}✗ Error: No se encuentra Grammars.y en $SOURCE_DIR${NC}"
        return 1
    fi
    
    # Compilar con alex
    echo -e "${CYAN}  - Compilando lexer con alex...${NC}"
    alex Lex.x 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error en alex${NC}"
        return 1
    fi
    
    # Compilar con happy
    echo -e "${CYAN}  - Compilando parser con happy...${NC}"
    happy Grammars.y --ghc 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error en happy${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✓ Compilación exitosa${NC}\n"
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
    return 0
}

# Menú principal
show_main_menu() {
    echo -e "${BLUE}═══════════════════ MENÚ PRINCIPAL ═══════════════════${NC}"
    echo -e "${GREEN}1.${NC} Ejecutar Pruebas Completas del Sistema"
    echo -e "${GREEN}2.${NC} Ejecutar Pruebas Especiales (map, filter, factorial, etc.)"
    echo -e "${GREEN}3.${NC} Ejecutar Pruebas por Módulo Individual"
    echo -e "${GREEN}4.${NC} (no disponible)"
    echo -e "${GREEN}5.${NC} Recompilar Proyecto"
    echo -e "${GREEN}6.${NC} Salir"
    echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
    echo -n "Selecciona una opción: "
}

# Menú de pruebas por módulo
show_module_menu() {
    clear
    show_banner
    echo -e "${BLUE}═══════════════ PRUEBAS POR MÓDULO ══════════════════${NC}"
    echo -e "${GREEN}1.${NC} Pruebas del Lexer"
    echo -e "${GREEN}2.${NC} Pruebas del Parser"
    echo -e "${GREEN}3.${NC} Pruebas del Desugar"
    echo -e "${GREEN}4.${NC} Pruebas del SmallStep"
    echo -e "${GREEN}5.${NC} Volver al menú principal"
    echo -e "${BLUE}══════════════════════════════════════════════════════${NC}"
    echo -n "Selecciona una opción: "
}

# Ejecutar pruebas completas
run_full_tests() {
    clear
    show_banner
    echo -e "${MAGENTA}═══════════════ PRUEBAS COMPLETAS DEL SISTEMA ═══════════════${NC}\n"
    
    if [ -f "$SCRIPT_DIR/test_full_system.sh" ]; then
        bash "$SCRIPT_DIR/test_full_system.sh"
    else
        echo -e "${RED}Error: No se encontró test_full_system.sh en $SCRIPT_DIR${NC}"
    fi
    
    echo -e "\n${YELLOW}Presiona Enter para continuar...${NC}"
    read
}

# Ejecutar pruebas especiales
run_special_tests() {
    clear
    show_banner
    echo -e "${MAGENTA}═══════════════ PRUEBAS ESPECIALES ═══════════════${NC}\n"
    
    if [ -f "$SCRIPT_DIR/test_special.sh" ]; then
        bash "$SCRIPT_DIR/test_special.sh"
    else
        echo -e "${RED}Error: No se encontró test_special.sh en $SCRIPT_DIR${NC}"
    fi
    
    echo -e "\n${YELLOW}Presiona Enter para continuar...${NC}"
    read
}

# Modo interactivo
interactive_mode() {
    clear
    show_banner
    echo -e "${MAGENTA}═══════════════ MODO INTERACTIVO (REPL) ═══════════════${NC}"
    echo -e "${YELLOW}Escribe expresiones de MiniLisp y presiona Enter para evaluarlas${NC}"
    echo -e "${YELLOW}Escribe '(exit)' para salir${NC}\n"
    
    cd "$SOURCE_DIR"
    
    if [ -f "It_Minilisp.hs" ]; then
        ghci -v0 It_Minilisp.hs 2>/dev/null <<EOF
run
EOF
    else
        echo -e "${RED}Error: No se encuentra It_Minilisp.hs en $SOURCE_DIR${NC}"
    fi
    
    cd "$SCRIPT_DIR"
    echo -e "\n${YELLOW}Presiona Enter para continuar...${NC}"
    read
}

# Ejecutar pruebas de módulo específico
run_module_tests() {
    local module=$1
    clear
    show_banner
    
    case $module in
        1)
            echo -e "${MAGENTA}═══════════════ PRUEBAS DEL LEXER ═══════════════${NC}\n"
            if [ -f "$SCRIPT_DIR/test_lexer.sh" ]; then
                bash "$SCRIPT_DIR/test_lexer.sh"
            else
                echo -e "${RED}Error: No se encontró test_lexer.sh${NC}"
            fi
            ;;
        2)
            echo -e "${MAGENTA}═══════════════ PRUEBAS DEL PARSER ═══════════════${NC}\n"
            if [ -f "$SCRIPT_DIR/test_parser.sh" ]; then
                bash "$SCRIPT_DIR/test_parser.sh"
            else
                echo -e "${RED}Error: No se encontró test_parser.sh${NC}"
            fi
            ;;
        3)
            echo -e "${MAGENTA}═══════════════ PRUEBAS DEL DESUGAR ═══════════════${NC}\n"
            if [ -f "$SCRIPT_DIR/test_desugar.sh" ]; then
                bash "$SCRIPT_DIR/test_desugar.sh"
            else
                echo -e "${RED}Error: No se encontró test_desugar.sh${NC}"
            fi
            ;;
        4)
            echo -e "${MAGENTA}═══════════════ PRUEBAS DEL SMALLSTEP ═══════════════${NC}\n"
            if [ -f "$SCRIPT_DIR/test_smallstep.sh" ]; then
                bash "$SCRIPT_DIR/test_smallstep.sh"
            else
                echo -e "${RED}Error: No se encontró test_smallstep.sh${NC}"
            fi
            ;;
    esac
    
    echo -e "\n${YELLOW}Presiona Enter para continuar...${NC}"
    read
}

# Loop principal
main() {
    show_banner
    
    # Compilar al inicio
    compile_project
    if [ $? -ne 0 ]; then
        echo -e "${RED}No se puede continuar sin compilación exitosa${NC}"
        echo -e "${YELLOW}Verifica la estructura del proyecto${NC}"
        exit 1
    fi
    
    while true; do
        show_banner
        show_main_menu
        read option
        
        case $option in
            1)
                run_full_tests
                ;;
            2)
                run_special_tests
                ;;
            3)
                while true; do
                    show_module_menu
                    read module_option
                    
                    if [ "$module_option" == "5" ]; then
                        break
                    elif [[ "$module_option" =~ ^[1-4]$ ]]; then
                        run_module_tests $module_option
                    else
                        echo -e "${RED}Opción inválida${NC}"
                        sleep 1
                    fi
                done
                ;;
            4)
                interactive_mode
                ;;
            5)
                compile_project
                echo -e "\n${YELLOW}Presiona Enter para continuar...${NC}"
                read
                ;;
            6)
                echo -e "\n${CYAN}¡Hasta luego!${NC}\n"
                exit 0
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                sleep 1
                ;;
        esac
    done
}

# Iniciar el programa
main
