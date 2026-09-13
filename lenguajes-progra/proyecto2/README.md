# Intérprete de Expresiones Aritméticas usando el Combinador Y
## Estructura del Proyecto

```
.
├── Expr.hs                     # Tipo de datos para expresiones
├── YCombinator.hs              # Implementación del combinador Y
├── Evaluator.hs                # Evaluador usando el combinador Y
├── Lex.x                       # Especificación del lexer (Alex)
├── Grammar.y                   # Especificación del parser (Happy)
├── recursion_combinador_y.tex  # Documentación completa del proyecto
└── README.md                   # Este archivo
```

## Componentes del Intérprete

- **`Expr.hs`** - Define el tipo de datos `Expr` con constructores: `NumV`, `AddV`, `SubV`, `MultV`, `DivV`
- **`YCombinator.hs`** - Implementa el combinador Y de punto fijo: `yFix f = f (yFix f)`
- **`Evaluator.hs`** - Define `evalMaker` (función casi-recursiva) y `evalExpr = yFix evalMaker`
- **`Lex.x`** - Analizador léxico que reconoce números, operadores y paréntesis
- **`Grammar.y`** - Parser que construye el AST a partir de expresiones en sintaxis concreta

## Requisitos

- **GHC** (Glasgow Haskell Compiler)
- **Alex** (generador de analizadores léxicos)
- **Happy** (generador de parsers)

### Instalación en macOS:
```bash
brew install ghc alex happy
```

### Instalación en Linux:
```bash
# Debian/Ubuntu
sudo apt-get install ghc alex happy

# Arch Linux
sudo pacman -S ghc alex happy
```

## Cómo Probar el Intérprete

### Opción 1: Usando GHCi (Interactivo)

#### Paso 1: Generar lexer y parser
```bash
alex Lex.x
happy Grammar.y
```

#### Paso 2: Cargar en GHCi
```bash
ghci Grammar.hs
```

#### Paso 3: Probar expresiones
```haskell
ghci> import Evaluator

-- Parsear y evaluar una expresión
ghci> let expr1 = parseExpr "(+ 5 3)"
ghci> expr1
AddV (NumV 5) (NumV 3)

ghci> evalExpr expr1
8

-- Probar directamente
ghci> evalExpr (parseExpr "(* (- 10 2) 3)")
24

ghci> evalExpr (parseExpr "(* (+ (/ 15 3) 2) (- 8 3))")
35

-- División por cero (lanza error)
ghci> evalExpr (parseExpr "(/ 5 (- 3 3))")
*** Exception: Division por cero
```

#### Limpiar archivos (jiji) para que no se llene de basura su sistema de archivos
```bash
rm -f *.hi *.o Lex.hs Grammar.hs Grammar.info
```

### Opción 2: Crear tu propio programa de prueba

Crear un archivo `Test.hs`:

```haskell
module Main where

import Expr
import Evaluator
import Grammar (parseExpr)

main :: IO ()
main = do
    -- Prueba 1: Suma simple
    putStrLn "Prueba 1: (+ 5 3)"
    print $ evalExpr (parseExpr "(+ 5 3)")

    -- Prueba 2: Expresión anidada
    putStrLn "\nPrueba 2: (* (- 10 2) 3)"
    print $ evalExpr (parseExpr "(* (- 10 2) 3)")

    -- Prueba 3: Expresión compleja
    putStrLn "\nPrueba 3: (* (+ (/ 15 3) 2) (- 8 3))"
    print $ evalExpr (parseExpr "(* (+ (/ 15 3) 2) (- 8 3))")

    -- Añade más pruebas aquí...
```

Luego compilar y ejecutar:
```bash
alex Lex.x
happy Grammar.y
ghc -o test Test.hs
./test
```

Limpiar después:
```bash
rm -f *.hi *.o Lex.hs Grammar.hs test Grammar.info
```

## Sintaxis del Lenguaje

```
Expresión ::= número
            | (+ Expresión Expresión)
            | (- Expresión Expresión)
            | (* Expresión Expresión)
            | (/ Expresión Expresión)
```

## Ejemplos de Expresiones para Probar

### Expresiones Simples
```haskell
parseExpr "(+ 5 3)"      -- Suma: 8
parseExpr "(- 10 2)"     -- Resta: 8
parseExpr "(* 4 7)"      -- Multiplicación: 28
parseExpr "(/ 20 4)"     -- División: 5
```

### Expresiones Anidadas
```haskell
parseExpr "(* (- 10 2) 3)"                    -- 24
parseExpr "(+ (/ 15 3) 2)"                    -- 7
parseExpr "(- (* 5 4) (+ 3 2))"              -- 15
```

### Expresiones Complejas
```haskell
parseExpr "(* (+ (/ 15 3) 2) (- 8 3))"       -- 35
parseExpr "(/ (* (- 20 5) (+ 3 2)) 5)"       -- 15
parseExpr "(+ (* 2 3) (* 4 5))"              -- 26
```

### Números Negativos
```haskell
parseExpr "(+ -5 10)"     -- 5
parseExpr "(* -3 -4)"     -- 12
parseExpr "(- 0 5)"       -- -5
```

### Manejo de Errores
```haskell
parseExpr "(/ 5 0)"           -- Error: División por cero
parseExpr "(/ 5 (- 3 3))"     -- Error: División por cero
```

## Conceptos Demostrados

Este proyecto implementa y demuestra:

1. **Combinador Y** - Permite recursión sin autorreferencia nominal
   ```haskell
   evalExpr = yFix evalMaker
   ```

2. **Punto Fijo** - Cumple la propiedad matemática
   ```
   evalExpr = evalMaker evalExpr
   ```

3. **Autointerpretación** - El evaluador se usa a sí mismo para evaluar subexpresiones
   ```haskell
   evalMaker evalRec expr = case expr of
       AddV e1 e2 -> evalRec e1 + evalRec e2  -- evalRec llama recursivamente
   ```

4. **Meta-programación** - Manipula representaciones de programas (AST) como datos

## Documentación Completa

Ver **`recursion_combinador_y.tex`** para:
- Fundamentos teóricos del combinador Y
- Demostración de la propiedad de punto fijo
- Explicación detallada de autointerpretación
- Relación con el cálculo lambda y teoría de la computabilidad
