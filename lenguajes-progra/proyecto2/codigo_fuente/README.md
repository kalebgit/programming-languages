# Código Fuente: Combinador Y y Autointerpretación

Este directorio contiene el código fuente completo del proyecto sobre el Combinador Y, recursión sin auto-referencia, autointerpretación y metaprogramación.

## Estructura de Archivos

```
codigo_fuente/
├── Expr.hs              - Definición del tipo de datos ASAValues
├── YCombinator.hs       - Implementación del combinador Y
├── Evaluator.hs         - Evaluador con ejemplos de uso
├── Lex.x                - Definición del analizador léxico (lexer)
├── Grammar.y            - Definición de la gramática del lenguaje (parser)
├── Autointerprete.hs    - Demostración de autointerpretación
├── Metaprogramacion.hs  - Demostración de metaprogramación
└── README.md            - Este archivo
```

**Nota:** Los tests formales (`TestExpresiones.hs`, `TestAutointerprete.hs` y `TestMetaprogramacion.hs`) están en el directorio raíz del proyecto.

## Requisitos

- GHC (Glasgow Haskell Compiler) versión 8.0 o superior
- Sistema operativo: Linux, macOS o Windows

## Instalación de GHC

### macOS
```bash
brew install ghc
```

### Linux (Ubuntu/Debian)
```bash
sudo apt-get install ghc
```

### Windows
Descargar e instalar desde: https://www.haskell.org/platform/

## Compilación y Ejecución

### 1. Evaluador de Expresiones

Este módulo contiene el evaluador básico con ejemplos de uso.

**Compilar:**
```bash
ghc -o evaluador Evaluator.hs
```

**Nota:** Para ejecutar `Evaluator.hs` como programa principal:
1. Cambiar `module Evaluator where` a `module Main where`
2. Cambiar `pruebaEvaluador` a `main`
3. Compilar y ejecutar

**Salida esperada:**
```
==========================================
EVALUADOR DE EXPRESIONES CON COMBINADOR Y
==========================================

EJEMPLO 1: Suma simple
  Expresion: (+ 2 3)
  Resultado: 5

EJEMPLO 2: Expresion anidada
  Expresion: (* (+ 3 4) (- 10 2))
  Resultado: 56
...
```

**Demuestra:**
- Evaluación básica con el combinador Y
- Propiedad: `evalExpr = evalMaker evalExpr`

---

### 2. Autointérprete

Este programa demuestra la autointerpretación: un intérprete que se pasa a sí mismo como argumento.

**Compilar:**
```bash
ghc -o autointerprete Autointerprete.hs
```

**Ejecutar:**
```bash
./autointerprete
```

**Salida esperada:**
```
=== AUTOINTERPRETE CON COMBINADOR Y ===

Expresion 1: (+ 2 3)
Resultado: 5

Expresion 2: (* (+ 3 4) (- 10 2))
Resultado: 56

Propiedad de autointerpretacion:
  interprete = interpreteMaker interprete
  El interprete se pasa a si mismo como argumento
  Esto es AUTOINTERPRETACION gracias al combinador Y
```

**Demuestra:**
- Cómo el intérprete se usa a sí mismo para evaluar subexpresiones
- La propiedad fundamental: `interprete = interpreteMaker interprete`
- Autointerpretación habilitada por el combinador Y

---

### 3. Metaprogramación

Este programa demuestra capacidades de metaprogramación: inspección y transformación de código.

**Compilar:**
```bash
ghc -o metaprogramacion Metaprogramacion.hs
```

**Ejecutar:**
```bash
./metaprogramacion
```

**Salida esperada:**
```
==========================================
METAPROGRAMACION CON COMBINADOR Y
==========================================

1. INSPECCION DE CODIGO
====================
Expresion: (+ 5 3)
Contiene division? False
Evaluacion segura: 8

Expresion: (/ 10 2)
Contiene division? True
ADVERTENCIA: Contiene division

2. OPTIMIZACION DE CODIGO
======================
Expresion original: (+ (* 0 999) 5)
Expresion optimizada: (+ 0 5)
Resultado sin optimizar: 5
Resultado optimizado: 5
...
```

**Demuestra:**
- **Inspección de código**: Analizar estructura del programa antes de ejecutarlo
- **Optimización de código**: Transformar el programa para mejorar eficiencia
- Metaprogramación habilitada por autointerpretación

---

## Compilar Todos los Programas de Demostración

```bash
# Compilar todos los programas de demostración
ghc -o autointerprete Autointerprete.hs
ghc -o metaprogramacion Metaprogramacion.hs
```

**Nota:** `Evaluator.hs` es un módulo que puede ser importado. Para ejecutarlo, seguir las instrucciones en la Sección 1.

## Limpiar Archivos Generados

```bash
# Eliminar archivos compilados
rm -f *.hi *.o autointerprete metaprogramacion
```

## Descripción de Módulos

### Expr.hs
Define el tipo de datos `ASAValues` que representa expresiones aritméticas:
- `NumV Int` - Números enteros
- `AddV ASAValues ASAValues` - Suma
- `SubV ASAValues ASAValues` - Resta
- `MultV ASAValues ASAValues` - Multiplicación
- `DivV ASAValues ASAValues` - División

### YCombinator.hs
Implementa el combinador Y de punto fijo:
```haskell
yFix :: ((a -> b) -> (a -> b)) -> (a -> b)
yFix f = f (yFix f)
```

Esta función encuentra el punto fijo de una función, permitiendo recursión sin auto-referencia.

### Evaluator.hs
Implementa el evaluador de expresiones usando el combinador Y:
- `evalMaker` - Función "casi-recursiva" que genera el evaluador
- `evalExpr` - Evaluador completo: `evalExpr = yFix evalMaker`
- `pruebaEvaluador` - Función con ejemplos de uso
- Ejemplos predefinidos: `ejemplo1`, `ejemplo2`, `ejemplo3`, `ejemplo4`

**Propiedad clave**: `evalMaker` nunca se llama a sí misma por nombre.

### Autointerprete.hs
Demuestra autointerpretación:
- `interpreteMaker` - Generador del intérprete
- `interprete` - Autointérprete: `interprete = yFix interpreteMaker`

El intérprete se pasa a sí mismo como argumento para evaluar subexpresiones.

### Metaprogramacion.hs
Demuestra dos tipos de metaprogramación:

1. **Inspección de código**:
   - `contieneDivision` - Detecta si una expresión contiene divisiones
   - `evaluacionSegura` - Evalúa solo si es seguro

2. **Optimización de código**:
   - `optimizar` - Elimina operaciones redundantes (suma con 0, mult por 1, etc.)
   - `evalOptimizado` - Pipeline que optimiza antes de evaluar

Incluye función `main` con múltiples ejemplos de inspección y optimización.

### Lex.x
Definición del analizador léxico (lexer) del lenguaje:
- Define los tokens del lenguaje (números, operadores, paréntesis)
- Maneja espacios en blanco y comentarios
- Se procesa con Alex para generar el lexer en Haskell

### Grammar.y
Definición de la gramática del lenguaje (parser):
- Define la sintaxis del lenguaje de expresiones aritméticas
- Especifica la precedencia y asociatividad de operadores
- Se procesa con Happy para generar el parser en Haskell
- Produce valores de tipo `ASAValues`

## Conceptos Teóricos Demostrados

1. **Recursión sin Auto-Referencia**
   - Las funciones nunca se llaman a sí mismas por nombre
   - La recursión viene completamente del combinador Y

2. **Punto Fijo**
   - `f x = x` donde `x = yFix f`
   - `evalExpr = evalMaker evalExpr`

3. **Autointerpretación**
   - El intérprete se interpreta a sí mismo
   - Propiedad: `interprete = interpreteMaker interprete`

4. **Metaprogramación**
   - El código puede inspeccionarse a sí mismo
   - El código puede transformarse a sí mismo
   - Habilitado por la autointerpretación

## Tests Formales

Los tests formales que verifican el correcto funcionamiento de todos estos conceptos se encuentran en el **directorio raíz del proyecto**:

- `TestExpresiones.hs` - Tests con expansiones paso a paso de la evaluación recursiva
- `TestAutointerprete.hs` - 10 tests formales de autointerpretación
- `TestMetaprogramacion.hs` - 12 tests formales de metaprogramación

Para compilar y ejecutar los tests:
```bash
cd ..  # Ir al directorio raíz
ghc -o test_expresiones TestExpresiones.hs
ghc -o test_autointerprete TestAutointerprete.hs
ghc -o test_metaprogramacion TestMetaprogramacion.hs
./test_expresiones
./test_autointerprete
./test_metaprogramacion
```

## Notas Adicionales

- Todos los programas usan evaluación perezosa de Haskell
- La versión del combinador Y está adaptada para Haskell (usa `yFix`)
- Los programas incluyen comentarios explicativos detallados
- Las salidas muestran claramente cada concepto demostrado
- Los programas de demostración en este directorio están diseñados para ser ejecutados y mostrar ejemplos
- Los tests formales (en el directorio raíz) verifican la correctitud de las implementaciones

## Referencias

Para más información sobre la teoría detrás de este código, consultar:
- `recursion_combinador_y.tex` - Documento completo del proyecto
- `presentacion_combinador_y.tex` - Diálogo para presentación
- `dialogo_demostraciones.tex` - Guión para demostraciones en vivo

## Autor

Jiménez Rivera Emiliano Kaleb
Lenguajes de Programación
Facultad de Ciencias, UNAM
