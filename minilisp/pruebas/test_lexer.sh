#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Directorios
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/../code"

# Contadores
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Función para ejecutar una prueba del lexer
run_lexer_test() {
    local test_name="$1"
    local input="$2"
    local expected="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${CYAN}Test #${TOTAL_TESTS}: ${test_name}${NC}"
    echo -e "${YELLOW}Input:${NC} ${input}"
    echo -e "${YELLOW}Expected Tokens:${NC}"
    echo -e "${BLUE}${expected}${NC}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Crear archivo temporal con el código Haskell
    cat > /tmp/test_lexer_$$.hs <<EOF
import Lex

main = do
    let tokens = lexer "${input}"
    mapM_ print tokens
EOF
    
    # Ejecutar y capturar resultado
    output=$(ghc -v0 /tmp/test_lexer_$$.hs -o /tmp/test_lexer_$$ 2>&1 && /tmp/test_lexer_$$ 2>&1)
    exit_code=$?
    
    # Verificar si el output contiene los tokens esperados
    if [ $exit_code -eq 0 ]; then
        # Limpiar el output
        actual=$(echo "$output" | tr '\n' ' ')
        
        # Verificar que contenga los tokens esperados
        if echo "$actual" | grep -q "$(echo $expected | sed 's/\[/\\[/g' | sed 's/\]/\\]/g')"; then
            echo -e "${GREEN}✓ PASSED${NC}"
            echo -e "${GREEN}Output:${NC}"
            echo "$output"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "${RED}✗ FAILED${NC}"
            echo -e "${RED}Expected tokens not found${NC}"
            echo -e "${RED}Got:${NC}"
            echo "$output"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    else
        echo -e "${RED}✗ FAILED - Error de compilación o ejecución${NC}"
        echo "$output" | head -n 5
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
    
    # Limpiar archivos temporales
    rm -f /tmp/test_lexer_$$.hs /tmp/test_lexer_$$
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
}

echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              PRUEBAS DEL LEXER - MINILISP             ║${NC}"
echo -e "${MAGENTA}║           Análisis Léxico de Tokens                  ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}\n"

# ==========================================
# PRUEBAS DE NÚMEROS
# ==========================================
echo -e "${BLUE}【 NÚMEROS 】${NC}\n"

run_lexer_test \
    "Número positivo simple" \
    "42" \
    "TokenNum 42"

run_lexer_test \
    "Número negativo" \
    "-15" \
    "TokenNum (-15)"

run_lexer_test \
    "Número cero" \
    "0" \
    "TokenNum 0"

run_lexer_test \
    "Múltiples números" \
    "1 2 3" \
    "TokenNum 1.*TokenNum 2.*TokenNum 3"

# ==========================================
# PRUEBAS DE BOOLEANOS
# ==========================================
echo -e "${BLUE}【 BOOLEANOS 】${NC}\n"

run_lexer_test \
    "Booleano true" \
    "#t" \
    "TokenBool True"

run_lexer_test \
    "Booleano false" \
    "#f" \
    "TokenBool False"

# ==========================================
# PRUEBAS DE OPERADORES ARITMÉTICOS
# ==========================================
echo -e "${BLUE}【 OPERADORES ARITMÉTICOS 】${NC}\n"

run_lexer_test \
    "Operador suma" \
    "+" \
    "TokenSum"

run_lexer_test \
    "Operador resta" \
    "-" \
    "TokenSub"

run_lexer_test \
    "Operador multiplicación" \
    "*" \
    "TokenMult"

run_lexer_test \
    "Operador división" \
    "/" \
    "TokenDiv"

run_lexer_test \
    "Operador add1" \
    "add1" \
    "TokenAdd1"

run_lexer_test \
    "Operador sub1" \
    "sub1" \
    "TokenSub1"

run_lexer_test \
    "Operador sqrt" \
    "sqrt" \
    "TokenSqrt"

run_lexer_test \
    "Operador expt" \
    "expt" \
    "TokenExpt"

# ==========================================
# PRUEBAS DE OPERADORES DE COMPARACIÓN
# ==========================================
echo -e "${BLUE}【 OPERADORES DE COMPARACIÓN 】${NC}\n"

run_lexer_test \
    "Operador igual" \
    "=" \
    "TokenEq"

run_lexer_test \
    "Operador menor que" \
    "<" \
    "TokenLt"

run_lexer_test \
    "Operador mayor que" \
    ">" \
    "TokenGt"

run_lexer_test \
    "Operador menor o igual" \
    "<=" \
    "TokenLeq"

run_lexer_test \
    "Operador mayor o igual" \
    ">=" \
    "TokenGeq"

run_lexer_test \
    "Operador diferente" \
    "!=" \
    "TokenNeq"

# ==========================================
# PRUEBAS DE OPERADORES LÓGICOS
# ==========================================
echo -e "${BLUE}【 OPERADORES LÓGICOS 】${NC}\n"

run_lexer_test \
    "Operador and" \
    "and" \
    "TokenAnd"

run_lexer_test \
    "Operador not" \
    "not" \
    "TokenNot"

run_lexer_test \
    "Palabra reservada if" \
    "if" \
    "TokenIf"

# ==========================================
# PRUEBAS DE PALABRAS RESERVADAS
# ==========================================
echo -e "${BLUE}【 PALABRAS RESERVADAS 】${NC}\n"

run_lexer_test \
    "Palabra reservada let" \
    "let" \
    "TokenLet"

run_lexer_test \
    "Palabra reservada let*" \
    "let*" \
    "TokenLetStar"

run_lexer_test \
    "Palabra reservada letrec" \
    "letrec" \
    "TokenLetRec"

run_lexer_test \
    "Palabra reservada cond" \
    "cond" \
    "TokenCond"

run_lexer_test \
    "Palabra reservada else" \
    "else" \
    "TokenElse"

run_lexer_test \
    "Palabra reservada lambda" \
    "lambda" \
    "TokenLambda"

# ==========================================
# PRUEBAS DE LISTAS
# ==========================================
echo -e "${BLUE}【 OPERADORES DE LISTAS 】${NC}\n"

run_lexer_test \
    "Operador concatenar" \
    "++" \
    "TokenConc"

run_lexer_test \
    "Operador head" \
    "head" \
    "TokenHead"

run_lexer_test \
    "Operador tail" \
    "tail" \
    "TokenTail"

run_lexer_test \
    "Corchetes" \
    "[ ]" \
    "TokenCA.*TokenCC"

run_lexer_test \
    "Coma" \
    "," \
    "TokenComma"

# ==========================================
# PRUEBAS DE PARES
# ==========================================
echo -e "${BLUE}【 OPERADORES DE PARES 】${NC}\n"

run_lexer_test \
    "Operador fst" \
    "fst" \
    "TokenFst"

run_lexer_test \
    "Operador snd" \
    "snd" \
    "TokenSnd"

# ==========================================
# PRUEBAS DE DELIMITADORES
# ==========================================
echo -e "${BLUE}【 DELIMITADORES 】${NC}\n"

run_lexer_test \
    "Paréntesis" \
    "( )" \
    "TokenPA.*TokenPC"

run_lexer_test \
    "Paréntesis anidados" \
    "( ( ) )" \
    "TokenPA.*TokenPA.*TokenPC.*TokenPC"

# ==========================================
# PRUEBAS DE VARIABLES
# ==========================================
echo -e "${BLUE}【 IDENTIFICADORES Y VARIABLES 】${NC}\n"

run_lexer_test \
    "Variable simple" \
    "x" \
    "TokenVar \"x\""

run_lexer_test \
    "Variable con mayúsculas" \
    "myVar" \
    "TokenVar \"myVar\""

run_lexer_test \
    "Variable con números" \
    "var123" \
    "TokenVar \"var123\""

run_lexer_test \
    "Variable con guión bajo" \
    "my_variable" \
    "TokenVar \"my_variable\""

# ==========================================
# PRUEBAS DE EXPRESIONES COMPLETAS
# ==========================================
echo -e "${BLUE}【 EXPRESIONES COMPLETAS 】${NC}\n"

run_lexer_test \
    "Suma simple" \
    "(+ 2 3)" \
    "TokenPA.*TokenSum.*TokenNum 2.*TokenNum 3.*TokenPC"

run_lexer_test \
    "Let simple" \
    "(let (x 5) x)" \
    "TokenPA.*TokenLet.*TokenPA.*TokenVar.*TokenNum 5.*TokenPC.*TokenVar.*TokenPC"

run_lexer_test \
    "Lambda" \
    "(lambda (x) (+ x 1))" \
    "TokenPA.*TokenLambda.*TokenPA.*TokenVar.*TokenPC.*TokenPA.*TokenSum.*TokenVar.*TokenNum 1.*TokenPC.*TokenPC"

run_lexer_test \
    "Lista" \
    "[1, 2, 3]" \
    "TokenCA.*TokenNum 1.*TokenComma.*TokenNum 2.*TokenComma.*TokenNum 3.*TokenCC"

run_lexer_test \
    "Condicional" \
    "(if #t 10 20)" \
    "TokenPA.*TokenIf.*TokenBool True.*TokenNum 10.*TokenNum 20.*TokenPC"

run_lexer_test \
    "Cond con else" \
    "(cond [(< x 5) 1] [else 2])" \
    "TokenPA.*TokenCond.*TokenCA.*TokenLt.*TokenVar.*TokenNum 5.*TokenPC.*TokenNum 1.*TokenCC.*TokenCA.*TokenElse.*TokenNum 2.*TokenCC.*TokenPC"

# ==========================================
# RESUMEN DE RESULTADOS
# ==========================================
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              RESUMEN DE RESULTADOS                    ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Total de pruebas del lexer:${NC} ${TOTAL_TESTS}"
echo -e "${GREEN}Pruebas exitosas:${NC} ${PASSED_TESTS}"
echo -e "${RED}Pruebas fallidas:${NC} ${FAILED_TESTS}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ¡Todas las pruebas del lexer pasaron! 🎉${NC}"
    echo -e "${GREEN}El análisis léxico funciona correctamente${NC}"
else
    PERCENTAGE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
    echo -e "\n${YELLOW}Porcentaje de éxito: ${PERCENTAGE}%${NC}"
fi

echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}\n"
