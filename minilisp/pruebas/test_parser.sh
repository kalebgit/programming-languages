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

# Función para ejecutar una prueba del parser
run_parser_test() {
    local test_name="$1"
    local input="$2"
    local expected_pattern="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${CYAN}Test #${TOTAL_TESTS}: ${test_name}${NC}"
    echo -e "${YELLOW}Input:${NC} ${input}"
    echo -e "${YELLOW}Expected AST Pattern:${NC}"
    echo -e "${BLUE}${expected_pattern}${NC}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Crear archivo temporal con el código Haskell
    cat > /tmp/test_parser_$$.hs <<EOF
import Lex
import Grammars

main = do
    let tokens = lexer "${input}"
    let ast = parser tokens
    print ast
EOF
    
    # Ejecutar y capturar resultado
    output=$(ghc -v0 /tmp/test_parser_$$.hs -o /tmp/test_parser_$$ 2>&1 && /tmp/test_parser_$$ 2>&1)
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        # Verificar que el output contenga el patrón esperado
        if echo "$output" | grep -q "$expected_pattern"; then
            echo -e "${GREEN}✓ PASSED${NC}"
            echo -e "${GREEN}AST generado:${NC}"
            echo "$output"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "${RED}✗ FAILED${NC}"
            echo -e "${RED}Pattern not found in AST${NC}"
            echo -e "${RED}Got:${NC}"
            echo "$output"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    else
        echo -e "${RED}✗ FAILED - Error de compilación o parsing${NC}"
        echo "$output" | head -n 10
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
    
    # Limpiar archivos temporales
    rm -f /tmp/test_parser_$$.hs /tmp/test_parser_$$
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
}

echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║             PRUEBAS DEL PARSER - MINILISP             ║${NC}"
echo -e "${MAGENTA}║        Análisis Sintáctico y Construcción AST        ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}\n"

# ==========================================
# PRUEBAS DE VALORES BÁSICOS
# ==========================================
echo -e "${BLUE}【 VALORES BÁSICOS 】${NC}\n"

run_parser_test \
    "Número positivo" \
    "42" \
    "Num 42"

run_parser_test \
    "Número negativo" \
    "-15" \
    "Num (-15)"

run_parser_test \
    "Booleano verdadero" \
    "#t" \
    "Boolean True"

run_parser_test \
    "Booleano falso" \
    "#f" \
    "Boolean False"

run_parser_test \
    "Variable" \
    "x" \
    "Var \"x\""

# ==========================================
# PRUEBAS DE OPERACIONES ARITMÉTICAS
# ==========================================
echo -e "${BLUE}【 OPERACIONES ARITMÉTICAS 】${NC}\n"

run_parser_test \
    "Suma simple" \
    "(+ 2 3)" \
    "Add.*Num 2.*Num 3"

run_parser_test \
    "Suma variádica" \
    "(+ 1 2 3 4)" \
    "Add.*Num 1.*Num 2.*Num 3.*Num 4"

run_parser_test \
    "Resta" \
    "(- 10 5)" \
    "Sub.*Num 10.*Num 5"

run_parser_test \
    "Multiplicación" \
    "(* 3 4)" \
    "Mult.*Num 3.*Num 4"

run_parser_test \
    "División" \
    "(/ 20 4)" \
    "Div.*Num 20.*Num 4"

run_parser_test \
    "Add1" \
    "(add1 5)" \
    "Add1.*Num 5"

run_parser_test \
    "Sub1" \
    "(sub1 10)" \
    "Sub1.*Num 10"

run_parser_test \
    "Raíz cuadrada" \
    "(sqrt 16)" \
    "Sqrt.*Num 16"

run_parser_test \
    "Exponenciación" \
    "(expt 2 3)" \
    "Expt.*Num 2.*Num 3"

# ==========================================
# PRUEBAS DE COMPARACIÓN
# ==========================================
echo -e "${BLUE}【 OPERADORES DE COMPARACIÓN 】${NC}\n"

run_parser_test \
    "Igualdad" \
    "(= 5 5)" \
    "Eq.*Num 5.*Num 5"

run_parser_test \
    "Menor que" \
    "(< 3 5)" \
    "Lt.*Num 3.*Num 5"

run_parser_test \
    "Mayor que" \
    "(> 5 3)" \
    "Gt.*Num 5.*Num 3"

run_parser_test \
    "Menor o igual" \
    "(<= 3 5)" \
    "Leq.*Num 3.*Num 5"

run_parser_test \
    "Mayor o igual" \
    "(>= 5 3)" \
    "Geq.*Num 5.*Num 3"

run_parser_test \
    "Diferente" \
    "(!= 5 3)" \
    "Neq.*Num 5.*Num 3"

# ==========================================
# PRUEBAS DE OPERADORES LÓGICOS
# ==========================================
echo -e "${BLUE}【 OPERADORES LÓGICOS 】${NC}\n"

run_parser_test \
    "NOT" \
    "(not #t)" \
    "Not.*Boolean True"

run_parser_test \
    "AND" \
    "(and #t #f)" \
    "And.*Boolean True.*Boolean False"

run_parser_test \
    "IF" \
    "(if #t 10 20)" \
    "If.*Boolean True.*Num 10.*Num 20"

run_parser_test \
    "IF con condición" \
    "(if (< 3 5) 100 200)" \
    "If.*Lt.*Num 100.*Num 200"

# ==========================================
# PRUEBAS DE PARES
# ==========================================
echo -e "${BLUE}【 PARES ORDENADOS 】${NC}\n"

run_parser_test \
    "Crear par" \
    "(1, 5)" \
    "Pair.*Num 1.*Num 5"

run_parser_test \
    "First de par" \
    "(fst (10, 20))" \
    "Fst.*Pair.*Num 10.*Num 20"

run_parser_test \
    "Second de par" \
    "(snd (10, 20))" \
    "Snd.*Pair.*Num 10.*Num 20"

# ==========================================
# PRUEBAS DE LISTAS
# ==========================================
echo -e "${BLUE}【 LISTAS 】${NC}\n"

run_parser_test \
    "Lista vacía" \
    "[]" \
    "List \[\]"

run_parser_test \
    "Lista simple" \
    "[1, 2, 3]" \
    "List.*Num 1.*Num 2.*Num 3"

run_parser_test \
    "Head de lista" \
    "(head [5, 10])" \
    "Head.*List.*Num 5.*Num 10"

run_parser_test \
    "Tail de lista" \
    "(tail [1, 2, 3])" \
    "Tail.*List.*Num 1.*Num 2.*Num 3"

run_parser_test \
    "Concatenar" \
    "(++ 1 [2, 3])" \
    "Conc.*Num 1.*List.*Num 2.*Num 3"

# ==========================================
# PRUEBAS DE LET
# ==========================================
echo -e "${BLUE}【 LET 】${NC}\n"

run_parser_test \
    "Let simple" \
    "(let (x 5) x)" \
    "Let.*\"x\".*Num 5.*Var \"x\""

run_parser_test \
    "Let con expresión" \
    "(let (x 5) (+ x 10))" \
    "Let.*\"x\".*Num 5.*Add.*Var \"x\".*Num 10"

run_parser_test \
    "Let múltiple" \
    "(let ((x 2) (y 5)) (+ x y))" \
    "Let.*\"x\".*Num 2.*\"y\".*Num 5.*Add"

# ==========================================
# PRUEBAS DE LET*
# ==========================================
echo -e "${BLUE}【 LET* 】${NC}\n"

run_parser_test \
    "Let* simple" \
    "(let* ((x 3) (y 5)) (+ x y))" \
    "LetStar.*\"x\".*Num 3.*\"y\".*Num 5.*Add"

run_parser_test \
    "Let* dependiente" \
    "(let* ((a 5) (b (* a 2))) b)" \
    "LetStar.*\"a\".*Num 5.*\"b\".*Mult.*Var \"a\""

# ==========================================
# PRUEBAS DE LETREC
# ==========================================
echo -e "${BLUE}【 LETREC 】${NC}\n"

run_parser_test \
    "Letrec con función" \
    "(letrec (fac (lambda (n) n)) (fac 5))" \
    "LetRec.*\"fac\".*Lambda.*\"n\".*Var \"n\".*App"

# ==========================================
# PRUEBAS DE LAMBDA
# ==========================================
echo -e "${BLUE}【 LAMBDA 】${NC}\n"

run_parser_test \
    "Lambda simple" \
    "(lambda (x) x)" \
    "Lambda.*\"x\".*Var \"x\""

run_parser_test \
    "Lambda con múltiples parámetros" \
    "(lambda (x y z) (+ x y z))" \
    "Lambda.*\"x\".*\"y\".*\"z\".*Add"

run_parser_test \
    "Aplicación de lambda" \
    "((lambda (x) (+ x 1)) 5)" \
    "App.*Lambda.*\"x\".*Add.*Num 5"

# ==========================================
# PRUEBAS DE COND
# ==========================================
echo -e "${BLUE}【 COND 】${NC}\n"

run_parser_test \
    "Cond simple con else" \
    "(cond [(< 2 5) 100] [else 200])" \
    "CondElse.*Lt.*Num 2.*Num 5.*Num 100.*Num 200"

run_parser_test \
    "Cond múltiples ramas" \
    "(cond [(< x 10) 1] [(= x 10) 2] [else 3])" \
    "CondElse.*Lt.*Var \"x\".*Num 10.*Num 1.*Eq.*Var \"x\".*Num 10.*Num 2.*Num 3"

# ==========================================
# PRUEBAS DE EXPRESIONES ANIDADAS
# ==========================================
echo -e "${BLUE}【 EXPRESIONES ANIDADAS 】${NC}\n"

run_parser_test \
    "Suma anidada" \
    "(+ (* 2 3) (- 10 5))" \
    "Add.*Mult.*Num 2.*Num 3.*Sub.*Num 10.*Num 5"

run_parser_test \
    "Let anidado" \
    "(let (x 3) (let (y 5) (+ x y)))" \
    "Let.*\"x\".*Num 3.*Let.*\"y\".*Num 5.*Add"

run_parser_test \
    "Lambda en let" \
    "(let (f (lambda (x) (* x x))) (f 7))" \
    "Let.*\"f\".*Lambda.*\"x\".*Mult.*App"

# ==========================================
# RESUMEN DE RESULTADOS
# ==========================================
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              RESUMEN DE RESULTADOS                    ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Total de pruebas del parser:${NC} ${TOTAL_TESTS}"
echo -e "${GREEN}Pruebas exitosas:${NC} ${PASSED_TESTS}"
echo -e "${RED}Pruebas fallidas:${NC} ${FAILED_TESTS}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ¡Todas las pruebas del parser pasaron! 🎉${NC}"
    echo -e "${GREEN}El análisis sintáctico funciona correctamente${NC}"
else
    PERCENTAGE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
    echo -e "\n${YELLOW}Porcentaje de éxito: ${PERCENTAGE}%${NC}"
fi

echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}\n"
