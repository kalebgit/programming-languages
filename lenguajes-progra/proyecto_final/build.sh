#!/bin/bash

# Script de compilación para Mini-Lisp
echo "=== Compilando Mini-Lisp ==="

# Generar el lexer con Alex
echo "Generando lexer con Alex..."
alex Lex.x
if [ $? -ne 0 ]; then
    echo "Error: Alex falló al generar el lexer"
    exit 1
fi

# Generar el parser con Happy
echo "Generando parser con Happy..."
happy Grammars.y
if [ $? -ne 0 ]; then
    echo "Error: Happy falló al generar el parser"
    exit 1
fi

# Compilar el proyecto con GHC
echo "Compilando con GHC..."
ghc --make It_Minilisp.hs -o minilisp
if [ $? -ne 0 ]; then
    echo "Error: GHC falló al compilar el proyecto"
    exit 1
fi

echo "=== Compilación exitosa ==="
echo ""
echo "Para ejecutar el programa, usa:"
echo "  ./minilisp"
echo ""
echo "Para compilar y ejecutar en un solo comando:"
echo "  ./build.sh && ./minilisp"
