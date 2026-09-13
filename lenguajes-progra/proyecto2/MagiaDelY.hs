{-
  ¿CÓMO FUNCIONA LA "MAGIA" DEL COMBINADOR Y?

  Vamos a desarrollar paso a paso cómo evalExpr = yFix evalMaker
  logra recursión sin que evalMaker se llame a sí misma.
-}

import YCombinator

-- Ejemplo simple: factorial
-- Vamos a construirlo paso a paso para ver la magia

-- ============================================================
-- PASO 1: Función tradicional (con recursión explícita)
-- ============================================================
factorialTradicional :: Int -> Int
factorialTradicional n
    | n <= 0    = 1
    | otherwise = n * factorialTradicional (n - 1)
                      -- ^^^^^^^^^^^^^^^^^^^^ se llama a sí misma


-- ============================================================
-- PASO 2: Convertir a función "casi-recursiva"
-- ============================================================
-- En lugar de llamarse a sí misma, recibe la recursión como parámetro

factorialMaker :: (Int -> Int) -> (Int -> Int)
factorialMaker rec n
    | n <= 0    = 1
    | otherwise = n * rec (n - 1)
                      -- ^^^ usa el parámetro, NO se auto-refiere

-- Nota: factorialMaker NO es recursiva por sí sola
-- Es solo una "plantilla" que necesita que le "inyecten" la recursión


-- ============================================================
-- PASO 3: El combinador Y "inyecta" la recursión
-- ============================================================
factorial :: Int -> Int
factorial = yFix factorialMaker

-- ¿Cómo funciona yFix?
-- Recordemos su definición: yFix f = f (yFix f)
--
-- Expandamos factorial 5:
--
-- factorial 5
-- = (yFix factorialMaker) 5
-- = (factorialMaker (yFix factorialMaker)) 5    -- aplicamos definición de yFix
-- = (factorialMaker factorial) 5                -- yFix factorialMaker = factorial
-- = 5 * factorial 4                             -- evalúa factorialMaker
-- = 5 * (yFix factorialMaker) 4
-- = 5 * (factorialMaker factorial) 4
-- = 5 * (4 * factorial 3)
-- = 5 * 4 * factorial 3
-- = 5 * 4 * 3 * factorial 2
-- = 5 * 4 * 3 * 2 * factorial 1
-- = 5 * 4 * 3 * 2 * 1 * factorial 0
-- = 5 * 4 * 3 * 2 * 1 * 1
-- = 120
--
-- ¡La recursión funciona sin que factorialMaker se llame a sí misma!


-- ============================================================
-- EL TRUCO: Propiedad de Punto Fijo
-- ============================================================
{-
El combinador Y encuentra el "punto fijo" de una función.

¿Qué es un punto fijo?
- Un valor x es punto fijo de f si: f(x) = x

Ejemplo numérico:
- f(x) = x² - 2x + 2
- El punto fijo es x=2, porque f(2) = 4 - 4 + 2 = 2

Para funciones de orden superior:
- factorial es el punto fijo de factorialMaker
- Porque: factorialMaker factorial = factorial

Verificación:
  factorialMaker factorial
  = factorial  (por propiedad de punto fijo)

Esto significa:
  factorialMaker factorial n
  = factorial n

Y por definición de factorialMaker:
  factorialMaker rec n = n * rec (n-1)

Entonces cuando rec = factorial:
  factorialMaker factorial n = n * factorial (n-1)

¡Eso es exactamente la recursión que queremos!

LA MAGIA: yFix automáticamente encuentra ese punto fijo
           sin que nosotros escribamos recursión explícita.
-}


-- ============================================================
-- APLICADO A TU PROYECTO: evalExpr
-- ============================================================
{-
En tu Evaluator.hs:

evalMaker :: (ASAValues -> Int) -> (ASAValues -> Int)
evalMaker evalRec expr = case expr of
    AddV e1 e2 -> evalRec e1 + evalRec e2
                  ^^^^^^^ parámetro, no auto-referencia
    ...

evalExpr :: ASAValues -> Int
evalExpr = yFix evalMaker
           ^^^^ encuentra el punto fijo

Propiedad de punto fijo:
  evalExpr = evalMaker evalExpr

Entonces cuando evalúas:
  evalExpr (AddV (NumV 2) (NumV 3))
  = (yFix evalMaker) (AddV (NumV 2) (NumV 3))
  = (evalMaker evalExpr) (AddV (NumV 2) (NumV 3))
  = evalExpr (NumV 2) + evalExpr (NumV 3)    -- expansión de evalMaker
  = 2 + 3
  = 5

¡Recursión sin que evalMaker se llame a sí misma!
-}


main :: IO ()
main = do
    putStrLn "=== COMPARACIÓN: Factorial Tradicional vs Con Y ==="
    putStrLn $ "factorialTradicional 5 = " ++ show (factorialTradicional 5)
    putStrLn $ "factorial (con Y)      5 = " ++ show (factorial 5)
    putStrLn ""
    putStrLn "=== LA DIFERENCIA CLAVE ==="
    putStrLn "1. factorialTradicional: se llama a sí misma por nombre"
    putStrLn "2. factorialMaker:       NUNCA se llama a sí misma"
    putStrLn "3. yFix:                 'inyecta' la recursión desde afuera"
    putStrLn ""
    putStrLn "=== ¿POR QUÉ ES IMPORTANTE? ==="
    putStrLn "- Demuestra que la recursión no es primitiva necesaria"
    putStrLn "- Se puede implementar con solo funciones de orden superior"
    putStrLn "- Base teórica del Cálculo Lambda (sin recursión explícita)"
    putStrLn "- Útil en lenguajes sin soporte nativo de recursión"
