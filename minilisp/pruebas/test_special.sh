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

# Función para ejecutar una prueba especial
run_special_test() {
    local test_name="$1"
    local description="$2"
    local input="$3"
    local expected="$4"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "${CYAN}═══════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}Test #${TOTAL_TESTS}: ${test_name}${NC}"
    echo -e "${MAGENTA}Descripción: ${description}${NC}"
    echo -e "${YELLOW}Input:${NC}"
    echo -e "${BLUE}${input}${NC}"
    echo -e "${YELLOW}Expected Output:${NC} ${expected}"
    
    # Cambiar al directorio de código
    cd "$SOURCE_DIR"
    
    # Crear archivo temporal con el código Haskell
    cat > /tmp/test_special_$$.hs <<EOF
import Lex
import Grammars
import Desugar
import SmallStep

main = do
    let result = interp (desugar (parser (lexer "${input}"))) []
    print result
EOF
    
    # Ejecutar y capturar resultado
    echo -e "${YELLOW}Ejecutando...${NC}"
    
    # Compilar
    ghc -v0 /tmp/test_special_$$.hs -o /tmp/test_special_$$ 2>&1 > /tmp/compile_output_$$.txt
    compile_exit=$?
    
    if [ $compile_exit -ne 0 ]; then
        echo -e "${RED}✗ FAILED - Error de compilación${NC}"
        echo -e "${RED}Errores de compilación:${NC}"
        cat /tmp/compile_output_$$.txt | head -n 5
        FAILED_TESTS=$((FAILED_TESTS + 1))
        rm -f /tmp/test_special_$$.hs /tmp/test_special_$$ /tmp/compile_output_$$.txt
        cd "$SCRIPT_DIR"
        echo ""
        return
    fi
    
    # Ejecutar el programa compilado
    /tmp/test_special_$$ 2>&1 > /tmp/output_$$.txt &
    TEST_PID=$!
    
    # Esperar máximo 30 segundos
    for i in {1..30}; do
        if ! kill -0 $TEST_PID 2>/dev/null; then
            break
        fi
        sleep 1
    done
    
    # Si aún está corriendo, matarlo
    if kill -0 $TEST_PID 2>/dev/null; then
        kill -9 $TEST_PID 2>/dev/null
        echo -e "${RED}✗ FAILED - Timeout (más de 30 segundos)${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        rm -f /tmp/test_special_$$.hs /tmp/test_special_$$ /tmp/compile_output_$$.txt /tmp/output_$$.txt
        cd "$SCRIPT_DIR"
        echo ""
        return
    fi
    
    # Leer el output
    output=$(cat /tmp/output_$$.txt 2>/dev/null)
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
            echo -e "${RED}Error durante la ejecución${NC}"
        fi
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
    
    # Limpiar archivos temporales
    rm -f /tmp/test_special_$$.hs /tmp/test_special_$$ /tmp/compile_output_$$.txt /tmp/output_$$.txt
    
    # Volver al directorio de pruebas
    cd "$SCRIPT_DIR"
}

echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║           PRUEBAS ESPECIALES - MINILISP               ║${NC}"
echo -e "${MAGENTA}║    Funciones Recursivas y de Orden Superior          ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}\n"

# ==========================================
# SUMA DE LOS PRIMEROS N NATURALES
# ==========================================
echo -e "${BLUE}【 SUMA DE LOS PRIMEROS N NATURALES 】${NC}\n"

run_special_test \
    "Suma de primeros 10 naturales" \
    "Suma recursiva: 1+2+3+...+10 = 55" \
    "(letrec (sum_n (lambda (n) (if (= n 0) 0 (+ n (sum_n (- n 1)))))) (sum_n 10))" \
    "NumV 55"

run_special_test \
    "Suma de primeros 5 naturales" \
    "Suma recursiva: 1+2+3+4+5 = 15" \
    "(letrec (sum_n (lambda (n) (if (= n 0) 0 (+ n (sum_n (- n 1)))))) (sum_n 5))" \
    "NumV 15"

run_special_test \
    "Suma de primeros 20 naturales" \
    "Suma recursiva: 1+2+...+20 = 210" \
    "(letrec (sum_n (lambda (n) (if (= n 0) 0 (+ n (sum_n (- n 1)))))) (sum_n 20))" \
    "NumV 210"

# ==========================================
# FACTORIAL
# ==========================================
echo -e "${BLUE}【 FACTORIAL 】${NC}\n"

run_special_test \
    "Factorial de 5" \
    "5! = 5×4×3×2×1 = 120" \
    "(letrec (fac (lambda (n) (if (= n 0) 1 (* n (fac (sub1 n)))))) (fac 5))" \
    "NumV 120"

run_special_test \
    "Factorial de 0" \
    "0! = 1 (caso base)" \
    "(letrec (fac (lambda (n) (if (= n 0) 1 (* n (fac (sub1 n)))))) (fac 0))" \
    "NumV 1"

run_special_test \
    "Factorial de 7" \
    "7! = 5040" \
    "(letrec (fac (lambda (n) (if (= n 0) 1 (* n (fac (sub1 n)))))) (fac 7))" \
    "NumV 5040"

# ==========================================
# FIBONACCI
# ==========================================
echo -e "${BLUE}【 FIBONACCI 】${NC}\n"

run_special_test \
    "Fibonacci de 0" \
    "fib(0) = 0" \
    "(letrec (fib (lambda (n) (if (<= n 1) n (+ (fib (sub1 n)) (fib (- n 2)))))) (fib 0))" \
    "NumV 0"

run_special_test \
    "Fibonacci de 1" \
    "fib(1) = 1" \
    "(letrec (fib (lambda (n) (if (<= n 1) n (+ (fib (sub1 n)) (fib (- n 2)))))) (fib 1))" \
    "NumV 1"

run_special_test \
    "Fibonacci de 5" \
    "fib(5) = 5 (secuencia: 0,1,1,2,3,5)" \
    "(letrec (fib (lambda (n) (if (<= n 1) n (+ (fib (sub1 n)) (fib (- n 2)))))) (fib 5))" \
    "NumV 5"

run_special_test \
    "Fibonacci de 8" \
    "fib(8) = 21" \
    "(letrec (fib (lambda (n) (if (<= n 1) n (+ (fib (sub1 n)) (fib (- n 2)))))) (fib 8))" \
    "NumV 21"

# ==========================================
# MAP
# ==========================================
echo -e "${BLUE}【 MAP - FUNCIÓN DE ORDEN SUPERIOR 】${NC}\n"

run_special_test \
    "Map - Elevar al cuadrado" \
    "Aplica (lambda (x) (* x x)) a [1,2,3]" \
    "(letrec (map (lambda (n) (if (= n []) [] (++ ((lambda (x) (* x x)) (head n)) (map (tail n)))))) (map [1, 2, 3]))" \
    "ConsV (NumV 1) (ConsV (NumV 4) (ConsV (NumV 9) NilV))"

run_special_test \
    "Map - Duplicar valores" \
    "Aplica (lambda (x) (* x 2)) a [5,10]" \
    "(letrec (map (lambda (n) (if (= n []) [] (++ ((lambda (x) (* x 2)) (head n)) (map (tail n)))))) (map [5, 10]))" \
    "ConsV (NumV 10) (ConsV (NumV 20) NilV)"

run_special_test \
    "Map - Lista vacía" \
    "Map sobre lista vacía debe devolver []" \
    "(letrec (map (lambda (n) (if (= n []) [] (++ ((lambda (x) (* x x)) (head n)) (map (tail n)))))) (map []))" \
    "NilV"

# ==========================================
# FILTER
# ==========================================
echo -e "${BLUE}【 FILTER - FUNCIÓN DE ORDEN SUPERIOR 】${NC}\n"

run_special_test \
    "Filter - Mayores que 8" \
    "Filtra elementos > 8 de [1,6,3,12,23,7]" \
    "(letrec (filter (lambda (n) (if (= n []) [] (++ (if (< (head n) 8) [] (head n)) (filter (tail n)))))) (filter [1, 6, 3, 12, 23, 7]))" \
    "ConsV (NumV 12) (ConsV (NumV 23) NilV)"

run_special_test \
    "Filter - Mayores que 10" \
    "Filtra elementos > 10 de [5,15,20]" \
    "(letrec (filter (lambda (n) (if (= n []) [] (++ (if (< (head n) 10) [] (head n)) (filter (tail n)))))) (filter [5, 15, 20]))" \
    "ConsV (NumV 15) (ConsV (NumV 20) NilV)"

run_special_test \
    "Filter - Ninguno cumple" \
    "Filtra elementos > 100 de [1,2,3] = []" \
    "(letrec (filter (lambda (n) (if (= n []) [] (++ (if (< (head n) 100) [] (head n)) (filter (tail n)))))) (filter [1, 2, 3]))" \
    "NilV"

# ==========================================
# FUNCIONES COMBINADAS
# ==========================================
echo -e "${BLUE}【 FUNCIONES COMBINADAS 】${NC}\n"

run_special_test \
    "Suma de lista" \
    "Suma elementos de lista [1,2,3,4,5]" \
    "(letrec (suma_lista (lambda (lst) (if (= lst []) 0 (+ (head lst) (suma_lista (tail lst)))))) (suma_lista [1, 2, 3, 4, 5]))" \
    "NumV 15"

run_special_test \
    "Longitud de lista" \
    "Calcula la longitud de [10,20,30,40]" \
    "(letrec (longitud (lambda (lst) (if (= lst []) 0 (+ 1 (longitud (tail lst)))))) (longitud [10, 20, 30, 40]))" \
    "NumV 4"

# ==========================================
# RESUMEN DE RESULTADOS
# ==========================================
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║              RESUMEN DE RESULTADOS                    ║${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Total de pruebas especiales:${NC} ${TOTAL_TESTS}"
echo -e "${GREEN}Pruebas exitosas:${NC} ${PASSED_TESTS}"
echo -e "${RED}Pruebas fallidas:${NC} ${FAILED_TESTS}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ¡Todas las pruebas especiales pasaron! 🎉${NC}"
    echo -e "${GREEN}Tu implementación de funciones recursivas es correcta${NC}"
else
    PERCENTAGE=$(( (PASSED_TESTS * 100) / TOTAL_TESTS ))
    echo -e "\n${YELLOW}Porcentaje de éxito: ${PERCENTAGE}%${NC}"
    echo -e "${YELLOW}Revisa las pruebas fallidas para depurar${NC}"
fi

echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}\n"
