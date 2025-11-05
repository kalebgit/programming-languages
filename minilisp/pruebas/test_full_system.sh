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

# Función para ejecutar una prueba
run_test() {
    local test_name="$1"
    local input="$2"
    local expected="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${CYAN}Test #${TOTAL_TESTS}: ${test_name}${NC}"
    echo -e "${YELLOW}Input:${NC} ${input}"
    echo -e "${YELLOW}Expected:${NC} ${expected}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Crear archivo temporal con el código Haskell
    cat > /tmp/test_minilisp_$$.hs <<EOF
import Lex
import Grammars
import Desugar
import SmallStep

main = do
    let result = interp (desugar (parser (lexer "${input}"))) []
    print result
EOF
    
    # Ejecutar y capturar resultado
    output=$(ghc -v0 /tmp/test_minilisp_$$.hs -o /tmp/test_minilisp_$$ 2>&1 && /tmp/test_minilisp_$$ 2>&1)
    exit_code=$?
    
    # Limpiar el output
    actual=$(echo "$output" | tail -n 1 | tr -d ' ')
    expected_clean=$(echo "$expected" | tr -d ' ')
    
    if [ $exit_code -eq 0 ] && [ "$actual" == "$expected_clean" ]; then
        echo -e "${GREEN}✓ PASSED${NC}"
        echo -e "${GREEN}Output:${NC} ${actual}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}✗ FAILED${NC}"
        echo -e "${RED}Expected:${NC} ${expected_clean}"
        echo -e "${RED}Got:${NC} ${actual}"
        if [ $exit_code -ne 0 ]; then
            echo -e "${RED}Error output:${NC}"
            echo "$output" | head -n 5
        fi
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
    
    # Limpiar archivos temporales
    rm -f /tmp/test_minilisp_$$.hs /tmp/test_minilisp_$$
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
}

echo -e "${MAGENTA}═══════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}    PRUEBAS COMPLETAS DEL SISTEMA MINILISP${NC}"
echo -e "${MAGENTA}═══════════════════════════════════════════════════${NC}\n"

# ==========================================
# PRUEBAS DE VALORES BÁSICOS
# ==========================================
echo -e "${BLUE}【 VALORES BÁSICOS 】${NC}\n"

run_test "Número entero positivo" "42" "NumV 42"
run_test "Número entero negativo" "-15" "NumV (-15)"
run_test "Booleano verdadero" "#t" "BooleanV True"
run_test "Booleano falso" "#f" "BooleanV False"

# ==========================================
# PRUEBAS ARITMÉTICAS
# ==========================================
echo -e "${BLUE}【 OPERACIONES ARITMÉTICAS 】${NC}\n"

run_test "Suma simple" "(+ 2 3)" "NumV 5"
run_test "Suma variádica" "(+ 1 2 3 4)" "NumV 10"
run_test "Suma con negativos" "(+ -5 10)" "NumV 5"

run_test "Resta simple" "(- 10 3)" "NumV 7"
run_test "Resta variádica" "(- 20 5 3)" "NumV 12"
run_test "Resta unaria (negación)" "(- 5)" "NumV (-5)"

run_test "Multiplicación simple" "(* 4 5)" "NumV 20"
run_test "Multiplicación variádica" "(* 2 3 4)" "NumV 24"
run_test "Multiplicación con cero" "(* 5 0)" "NumV 0"

run_test "División simple" "(/ 20 4)" "NumV 5"
run_test "División variádica" "(/ 100 5 2)" "NumV 10"
run_test "División entera" "(/ 7 2)" "NumV 3"

run_test "Add1" "(add1 5)" "NumV 6"
run_test "Sub1" "(sub1 10)" "NumV 9"

run_test "Raíz cuadrada" "(sqrt 16)" "NumV 4"
run_test "Raíz cuadrada (no exacta)" "(sqrt 10)" "NumV 3"

run_test "Exponenciación simple" "(expt 2 3)" "NumV 8"
run_test "Exponenciación con 0" "(expt 5 0)" "NumV 1"

# ==========================================
# PRUEBAS DE COMPARACIÓN
# ==========================================
echo -e "${BLUE}【 OPERADORES DE COMPARACIÓN 】${NC}\n"

run_test "Igualdad verdadera" "(= 5 5)" "BooleanV True"
run_test "Igualdad falsa" "(= 5 3)" "BooleanV False"
run_test "Igualdad variádica verdadera" "(= 3 3 3)" "BooleanV True"
run_test "Igualdad variádica falsa" "(= 3 3 4)" "BooleanV False"

run_test "Menor que verdadero" "(< 3 5)" "BooleanV True"
run_test "Menor que falso" "(< 5 3)" "BooleanV False"
run_test "Menor que variádico" "(< 1 2 3)" "BooleanV True"

run_test "Mayor que verdadero" "(> 5 3)" "BooleanV True"
run_test "Mayor que falso" "(> 3 5)" "BooleanV False"

run_test "Menor o igual verdadero" "(<= 3 5)" "BooleanV True"
run_test "Menor o igual igual" "(<= 5 5)" "BooleanV True"

run_test "Mayor o igual verdadero" "(>= 5 3)" "BooleanV True"
run_test "Mayor o igual igual" "(>= 5 5)" "BooleanV True"

run_test "Diferente verdadero" "(!= 5 3)" "BooleanV True"
run_test "Diferente falso" "(!= 5 5)" "BooleanV False"

# ==========================================
# PRUEBAS LÓGICAS
# ==========================================
echo -e "${BLUE}【 OPERADORES LÓGICOS 】${NC}\n"

run_test "NOT verdadero" "(not #t)" "BooleanV False"
run_test "NOT falso" "(not #f)" "BooleanV True"

run_test "AND verdadero" "(and #t #t)" "BooleanV True"
run_test "AND falso" "(and #t #f)" "BooleanV False"

run_test "IF verdadero" "(if #t 10 20)" "NumV 10"
run_test "IF falso" "(if #f 10 20)" "NumV 20"
run_test "IF con condición" "(if (< 3 5) 100 200)" "NumV 100"

# ==========================================
# PRUEBAS DE PARES
# ==========================================
echo -e "${BLUE}【 PARES ORDENADOS 】${NC}\n"

run_test "Crear par de números" "(1, 5)" "PairV (NumV 1) (NumV 5)"
run_test "Primer elemento del par" "(fst (10, 20))" "NumV 10"
run_test "Segundo elemento del par" "(snd (10, 20))" "NumV 20"

# ==========================================
# PRUEBAS DE LISTAS
# ==========================================
echo -e "${BLUE}【 LISTAS 】${NC}\n"

run_test "Lista vacía" "[]" "NilV"
run_test "Lista de un elemento" "[5]" "ConsV (NumV 5) NilV"
run_test "Lista simple" "[1, 2, 3]" "ConsV (NumV 1) (ConsV (NumV 2) (ConsV (NumV 3) NilV))"
run_test "Head de lista" "(head [5, 10, 15])" "NumV 5"
run_test "Tail de lista" "(tail [1, 2])" "ConsV (NumV 2) NilV"
run_test "Concatenar elemento" "(++ 1 [2, 3])" "ConsV (NumV 1) (ConsV (NumV 2) (ConsV (NumV 3) NilV))"

# ==========================================
# PRUEBAS DE LET
# ==========================================
echo -e "${BLUE}【 LET Y VARIABLES 】${NC}\n"

run_test "Let simple" "(let (x 5) x)" "NumV 5"
run_test "Let con expresión" "(let (x 5) (+ x 10))" "NumV 15"
run_test "Let anidado" "(let (x 3) (let (y 5) (+ x y)))" "NumV 8"
run_test "Let con operaciones" "(let (a 10) (let (b (* a 5)) (+ a b)))" "NumV 60"

# ==========================================
# PRUEBAS DE LET*
# ==========================================
echo -e "${BLUE}【 LET* SECUENCIAL 】${NC}\n"

run_test "Let* simple" "(let* ((x 3) (y (+ x 1))) (+ x y))" "NumV 7"
run_test "Let* dependiente" "(let* ((a 5) (b (* a 2))) (+ a b))" "NumV 15"

# ==========================================
# PRUEBAS DE FUNCIONES LAMBDA
# ==========================================
echo -e "${BLUE}【 FUNCIONES LAMBDA 】${NC}\n"

run_test "Lambda simple" "((lambda (x) (+ x 1)) 5)" "NumV 6"
run_test "Lambda múltiples parámetros" "((lambda (x y) (+ x y)) 3 7)" "NumV 10"
run_test "Lambda tres parámetros" "((lambda (x y z) (+ x y z)) 1 2 3)" "NumV 6"

run_test "Lambda con let" "(let (f (lambda (x) (* x x))) (f 7))" "NumV 49"

# ==========================================
# PRUEBAS DE COND
# ==========================================
echo -e "${BLUE}【 CONDICIONAL COND 】${NC}\n"

run_test "Cond primera rama" "(cond [(< 2 5) 100] [else 200])" "NumV 100"
run_test "Cond else" "(cond [(< 5 2) 100] [else 200])" "NumV 200"
run_test "Cond múltiples ramas" "(cond [(< 10 5) 1] [(= 10 10) 2] [else 3])" "NumV 2"

# ==========================================
# PRUEBAS COMBINADAS COMPLEJAS
# ==========================================
echo -e "${BLUE}【 EXPRESIONES COMPLEJAS 】${NC}\n"

run_test "Expresión aritmética compleja" "(+ (* 2 3) (- 10 5))" "NumV 11"

run_test "Lambda con condicional" \
    "((lambda (x) (if (< x 10) (* x 2) (+ x 10))) 5)" \
    "NumV 10"

run_test "Let con cond" \
    "(let (x 15) (cond [(< x 10) 1] [(< x 20) 2] [else 3]))" \
    "NumV 2"

# ==========================================
# RESUMEN DE RESULTADOS
# ==========================================
echo -e "${MAGENTA}═══════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}              RESUMEN DE RESULTADOS${NC}"
echo -e "${MAGENTA}═══════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Total de pruebas:${NC} ${TOTAL_TESTS}"
echo -e "${GREEN}Pruebas exitosas:${NC} ${PASSED_TESTS}"
echo -e "${RED}Pruebas fallidas:${NC} ${FAILED_TESTS}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ¡Todas las pruebas pasaron exitosamente! 🎉${NC}"
else
    PERCENTAGE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
    echo -e "\n${YELLOW}Porcentaje de éxito: ${PERCENTAGE}%${NC}"
fi

echo -e "${MAGENTA}═══════════════════════════════════════════════════${NC}\n"
