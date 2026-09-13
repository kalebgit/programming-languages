{-
  COMPARACIÓN: Intérprete Normal vs Intérprete con Combinador Y

  La diferencia NO está en el comportamiento (ambos evalúan igual)
  La diferencia está en CÓMO implementan la recursión
-}

import Expr
import YCombinator

-- ============================================================
-- ENFOQUE 1: Recursión Tradicional (como en tu proyecto anterior)
-- ============================================================

evalTradicional :: ASAValues -> Int
evalTradicional expr = case expr of
    NumV n -> n

    -- La función SE LLAMA A SÍ MISMA por nombre
    AddV e1 e2 -> evalTradicional e1 + evalTradicional e2
    --                ^^^^^^^^^^^^^^^ auto-referencia explícita

    SubV e1 e2 -> evalTradicional e1 - evalTradicional e2

    MultV e1 e2 -> evalTradicional e1 * evalTradicional e2

    DivV e1 e2 ->
        let v2 = evalTradicional e2
        in if v2 == 0
           then error "Division por cero"
           else evalTradicional e1 `div` v2


-- ============================================================
-- ENFOQUE 2: Con Combinador Y (tu proyecto actual)
-- ============================================================

-- Esta función NO es recursiva - recibe la recursión como parámetro
evalMaker :: (ASAValues -> Int) -> (ASAValues -> Int)
evalMaker evalRec expr = case expr of
    NumV n -> n

    -- NO se llama a sí misma, usa el parámetro 'evalRec'
    AddV e1 e2 -> evalRec e1 + evalRec e2
    --            ^^^^^^^ NO es auto-referencia, es un parámetro

    SubV e1 e2 -> evalRec e1 - evalRec e2

    MultV e1 e2 -> evalRec e1 * evalRec e2

    DivV e1 e2 ->
        let v2 = evalRec e2
        in if v2 == 0
           then error "Division por cero"
           else evalRec e1 `div` v2

-- El combinador Y "inyecta" la recursión
evalConY :: ASAValues -> Int
evalConY = yFix evalMaker
--         ^^^^ El combinador Y hace la magia aquí


-- ============================================================
-- LA DIFERENCIA CLAVE:
-- ============================================================
{-
1. RECURSIÓN TRADICIONAL (evalTradicional):
   - La función se llama a sí misma por nombre
   - Requiere que el lenguaje soporte recursión explícita
   - Es lo que normalmente escribes

2. COMBINADOR Y (evalMaker + yFix):
   - evalMaker NUNCA se refiere a sí misma
   - La recursión viene "desde afuera" vía el combinador Y
   - Demuestra que la recursión puede implementarse sin auto-referencia

PUNTO TEÓRICO IMPORTANTE:
- Esto prueba que NO necesitas recursión como primitiva del lenguaje
- Puedes implementar recursión usando solo funciones de orden superior
- Es la base del Cálculo Lambda puro (que no tiene recursión explícita)

ANALOGÍA:
Imagina que quieres hacer una función recursiva pero te prohiben
usar el nombre de la función dentro de su cuerpo.

TRADICIONAL (prohibido):
  factorial n = if n == 0 then 1 else n * factorial (n-1)
                                           ^^^^^^^^^ auto-referencia

CON COMBINADOR Y (permitido):
  factorialMaker rec n = if n == 0 then 1 else n * rec (n-1)
                                                    ^^^ parámetro
  factorial = yFix factorialMaker
              ^^^^ inyecta la recursión

-}


-- ============================================================
-- PRUEBA: Ambos dan el mismo resultado
-- ============================================================
main :: IO ()
main = do
    let expr = AddV (MultV (NumV 3) (NumV 4)) (NumV 5)  -- (+ (* 3 4) 5) = 17

    putStrLn "Evaluando: (+ (* 3 4) 5)"
    putStrLn $ "Con recursión tradicional: " ++ show (evalTradicional expr)
    putStrLn $ "Con combinador Y:          " ++ show (evalConY expr)
    putStrLn ""
    putStrLn "Resultado: ¡Son iguales!"
    putStrLn ""
    putStrLn "DIFERENCIA:"
    putStrLn "- Tradicional: usa auto-referencia (evalTradicional llama a evalTradicional)"
    putStrLn "- Combinador Y: NO usa auto-referencia (evalMaker NUNCA se llama a sí misma)"
    putStrLn "- La recursión viene del combinador Y, no de la función misma"
