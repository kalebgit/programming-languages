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

# Función para ejecutar una prueba del desugar
run_desugar_test() {
    local test_name="$1"
    local input="$2"
    local expected_pattern="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${CYAN}Test #${TOTAL_TESTS}: ${test_name}${NC}"
    echo -e "${YELLOW}Input:${NC} ${input}"
    echo -e "${YELLOW}Expected Core Pattern:${NC}"
    echo -e "${BLUE}${expected_pattern}${NC}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Crear archivo temporal con el código Haskell
    cat > /tmp/test_desugar_$$.hs <<EOF
import Lex
import Grammars
import Desugar

main = do
    let tokens = lexer "${input}"
    let ast = parser tokens
    let core = desugar ast
    print core
EOF
    
    # Ejecutar y capturar resultado
    output=$(ghc -v0 /tmp/test_desugar_$$.hs -o /tmp/test_desugar_$$ 2>&1 && /tmp/test_desugar_$$ 2>&1)
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        # Verificar que el output contenga el patrón esperado
        if echo "$output" | grep -q "$expected_pattern"; then
            echo -e "${GREEN}✓ PASSED${NC}"
            echo -e "${GREEN}Core generado:${NC}"
            echo "$output"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "${RED}✗ FAILED${NC}"
            echo -e "${RED}Pattern not found in Core${NC}"
            echo -e "${RED}Got:${NC}"
            echo "$output"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    else
        echo -e "${RED}✗ FAILED - Error de compilación o desugaring${NC}"
        echo "$output" | head -n 10
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
    
    # Limpiar archivos temporales
    rm -f /tmp/test_desugar_$$.hs /tmp/test_desugar_$$
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
}

echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║            PRUEBAS DEL DESUGAR - MINILISP             ║${NC}"
echo -e "${MAGENTA}║      Eliminación de Azúcar Sintáctica al Core        ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}\n"

# ==========================================
# PRUEBAS DE VALORES BÁSICOS (Sin desazucarizar)
# ==========================================
echo -e "${BLUE}【 VALORES BÁSICOS 】${NC}\n"

run_desugar_test \
    "Número" \
    "42" \
    "NumV 42"

run_desugar_test \
    "Booleano verdadero" \
    "#t" \
    "BooleanV True"

run_desugar_test \
    "Booleano falso" \
    "#f" \
    "BooleanV False"

run_desugar_test \
    "Variable" \
    "x" \
    "IdV \"x\""

# ==========================================
# OPERADORES VARIÁDICOS → BINARIOS
# ==========================================
echo -e "${BLUE}【 OPERADORES VARIÁDICOS → BINARIOS 】${NC}\n"

run_desugar_test \
    "Suma binaria (ya en core)" \
    "(+ 2 3)" \
    "AddV.*NumV 2.*NumV 3"

run_desugar_test \
    "Suma variádica → anidada" \
    "(+ 1 2 3 4)" \
    "AddV.*NumV 1.*AddV.*NumV 2.*AddV.*NumV 3.*NumV 4"

run_desugar_test \
    "Multiplicación variádica" \
    "(* 2 3 4)" \
    "MultV.*NumV 2.*MultV.*NumV 3.*NumV 4"

# ==========================================
# COMPARADORES VARIÁDICOS → AND DE COMPARACIONES
# ==========================================
echo -e "${BLUE}【 COMPARADORES VARIÁDICOS → AND 】${NC}\n"

run_desugar_test \
    "Igualdad variádica" \
    "(= 3 3 3)" \
    "AndV.*EqV.*NumV 3.*NumV 3.*EqV.*NumV 3.*NumV 3"

run_desugar_test \
    "Menor que variádico" \
    "(< 1 2 3)" \
    "AndV.*LtV.*NumV 1.*NumV 2.*LtV.*NumV 2.*NumV 3"

run_desugar_test \
    "Mayor o igual variádico" \
    "(>= 5 3 1)" \
    "AndV.*GeqV.*NumV 5.*NumV 3.*GeqV.*NumV 3.*NumV 1"

# ==========================================
# LISTAS → CONS Y NIL
# ==========================================
echo -e "${BLUE}【 LISTAS → CONS Y NIL 】${NC}\n"

run_desugar_test \
    "Lista vacía" \
    "[]" \
    "NilV"

run_desugar_test \
    "Lista simple → cons anidados" \
    "[1, 2, 3]" \
    "ConsV.*NumV 1.*ConsV.*NumV 2.*ConsV.*NumV 3.*NilV"

run_desugar_test \
    "Lista de un elemento" \
    "[5]" \
    "ConsV.*NumV 5.*NilV"

# ==========================================
# COND → IF ANIDADOS
# ==========================================
echo -e "${BLUE}【 COND → IF ANIDADOS 】${NC}\n"

run_desugar_test \
    "Cond simple con else" \
    "(cond [(< 2 5) 100] [else 200])" \
    "IfV.*LtV.*NumV 2.*NumV 5.*NumV 100.*NumV 200"

run_desugar_test \
    "Cond múltiples ramas" \
    "(cond [(< x 5) 1] [(= x 5) 2] [else 3])" \
    "IfV.*LtV.*IdV \"x\".*NumV 5.*NumV 1.*IfV.*EqV.*IdV \"x\".*NumV 5.*NumV 2.*NumV 3"

# ==========================================
# LAMBDA VARIÁDICA → CURRIFICADA
# ==========================================
echo -e "${BLUE}【 LAMBDA VARIÁDICA → CURRIFICADA 】${NC}\n"

run_desugar_test \
    "Lambda de un parámetro (ya core)" \
    "(lambda (x) x)" \
    "FunV \"x\".*IdV \"x\""

run_desugar_test \
    "Lambda de dos parámetros → currificada" \
    "(lambda (x y) (+ x y))" \
    "FunV \"x\".*FunV \"y\".*AddV.*IdV \"x\".*IdV \"y\""

run_desugar_test \
    "Lambda de tres parámetros → currificada" \
    "(lambda (x y z) (+ x y z))" \
    "FunV \"x\".*FunV \"y\".*FunV \"z\".*AddV.*IdV \"x\".*AddV.*IdV \"y\".*IdV \"z\""

# ==========================================
# APLICACIÓN MÚLTIPLE → APLICACIONES ANIDADAS
# ==========================================
echo -e "${BLUE}【 APLICACIÓN MÚLTIPLE → ANIDADAS 】${NC}\n"

run_desugar_test \
    "Aplicación con dos argumentos" \
    "((lambda (x y) (+ x y)) 3 5)" \
    "AppV.*AppV.*FunV \"x\".*FunV \"y\".*AddV.*NumV 3.*NumV 5"

run_desugar_test \
    "Aplicación con tres argumentos" \
    "((lambda (a b c) a) 1 2 3)" \
    "AppV.*AppV.*AppV.*FunV \"a\".*FunV \"b\".*FunV \"c\".*NumV 1.*NumV 2.*NumV 3"

# ==========================================
# LET → LAMBDA + APLICACIÓN
# ==========================================
echo -e "${BLUE}【 LET → LAMBDA + APLICACIÓN 】${NC}\n"

run_desugar_test \
    "Let simple" \
    "(let (x 5) x)" \
    "AppV.*FunV \"x\".*IdV \"x\".*NumV 5"

run_desugar_test \
    "Let con expresión" \
    "(let (x 5) (+ x 10))" \
    "AppV.*FunV \"x\".*AddV.*IdV \"x\".*NumV 10.*NumV 5"

run_desugar_test \
    "Let múltiple → lambda currificada" \
    "(let ((x 2) (y 5)) (+ x y))" \
    "AppV.*AppV.*FunV \"x\".*FunV \"y\".*AddV.*IdV \"x\".*IdV \"y\".*NumV 2.*NumV 5"

# ==========================================
# LET* → LETS ANIDADOS
# ==========================================
echo -e "${BLUE}【 LET* → LETS ANIDADOS 】${NC}\n"

run_desugar_test \
    "Let* de dos bindings" \
    "(let* ((x 3) (y 5)) (+ x y))" \
    "AppV.*FunV \"x\".*AppV.*FunV \"y\".*AddV.*IdV \"x\".*IdV \"y\".*NumV 5.*NumV 3"

run_desugar_test \
    "Let* con dependencia" \
    "(let* ((a 5) (b (* a 2))) b)" \
    "AppV.*FunV \"a\".*AppV.*FunV \"b\".*IdV \"b\".*MultV.*IdV \"a\".*NumV 2.*NumV 5"

# ==========================================
# LETREC → Z COMBINATOR
# ==========================================
echo -e "${BLUE}【 LETREC → Z COMBINATOR 】${NC}\n"

run_desugar_test \
    "Letrec simple" \
    "(letrec (f (lambda (x) x)) (f 5))" \
    "AppV.*FunV \"f\".*AppV.*IdV \"f\".*NumV 5"

# ==========================================
# OPERADORES ESPECIALES
# ==========================================
echo -e "${BLUE}【 OPERADORES ESPECIALES 】${NC}\n"

run_desugar_test \
    "Add1 → suma con 1" \
    "(add1 5)" \
    "AddV.*NumV 5.*NumV 1"

run_desugar_test \
    "Sub1 → resta con 1" \
    "(sub1 10)" \
    "SubV.*NumV 10.*NumV 1"

run_desugar_test \
    "Resta unaria → multiplicación por -1" \
    "(- 5)" \
    "MultV.*NumV (-1).*NumV 5"

# ==========================================
# EXPRESIONES COMBINADAS COMPLEJAS
# ==========================================
echo -e "${BLUE}【 EXPRESIONES COMBINADAS 】${NC}\n"

run_desugar_test \
    "Let con lambda currificada" \
    "(let (f (lambda (x y) (* x y))) (f 3 4))" \
    "AppV.*FunV \"f\".*AppV.*AppV.*IdV \"f\".*NumV 3.*NumV 4.*FunV \"x\".*FunV \"y\".*MultV"

run_desugar_test \
    "Cond con comparación variádica" \
    "(cond [(< 1 2 3) 100] [else 200])" \
    "IfV.*AndV.*LtV.*NumV 1.*NumV 2.*LtV.*NumV 2.*NumV 3.*NumV 100.*NumV 200"

run_desugar_test \
    "Lista con operación variádica" \
    "[1, (+ 2 3 4), 5]" \
    "ConsV.*NumV 1.*ConsV.*AddV.*NumV 2.*AddV.*NumV 3.*NumV 4.*ConsV.*NumV 5.*NilV"

# ==========================================
# RESUMEN DE RESULTADOS
# ==========================================
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              RESUMEN DE RESULTADOS                    ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Total de pruebas del desugar:${NC} ${TOTAL_TESTS}"
echo -e "${GREEN}Pruebas exitosas:${NC} ${PASSED_TESTS}"
echo -e "${RED}Pruebas fallidas:${NC} ${FAILED_TESTS}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ¡Todas las pruebas del desugar pasaron! 🎉${NC}"
    echo -e "${GREEN}La desazucarización funciona correctamente${NC}"
else
    PERCENTAGE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
    echo -e "\n${YELLOW}Porcentaje de éxito: ${PERCENTAGE}%${NC}"
fi

echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}\n"
