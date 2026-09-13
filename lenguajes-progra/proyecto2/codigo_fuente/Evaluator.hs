module Main where

import Expr
import YCombinator

-- Generador de la funcion de evaluacion
-- Esta es una funcion casi recursiva que toma como argumento
-- la funcion recursiva misma (evalRec)
--
-- Nota importante: evalMaker NUNCA se refiere a si misma por nombre
-- La recursion se logra completamente a traves del combinador Y

evalMaker :: (ASAValues -> Int) -> (ASAValues -> Int)
evalMaker evalRec expr = case expr of
    -- Caso base: numero
    NumV n -> n

    -- Casos recursivos: operaciones binarias
    -- Notar que usamos evalRec (no evalMaker) para las llamadas recursivas
    AddV e1 e2 -> evalRec e1 + evalRec e2
    --            El interprete se pasa a si mismo

    SubV e1 e2 -> evalRec e1 - evalRec e2

    MultV e1 e2 -> evalRec e1 * evalRec e2

    DivV e1 e2 ->
        let v2 = evalRec e2
        in if v2 == 0
           then error "Division por cero"
           else evalRec e1 `div` v2


-- Funcion de evaluacion obtenida aplicando el combinador Y
-- Esta es la funcion recursiva completa que podemos usar
--
-- Propiedad de punto fijo: evalExpr = evalMaker evalExpr
-- Es decir: el interprete se recibe a si mismo como argumento
-- Todas estas explicaciones tambien se desarrollan mas en el latex
evalExpr :: ASAValues -> Int
evalExpr = yFix evalMaker
-- evalExpr = evalMaker evalExpr
-- Asi vemos que el interprete se recibe a si mismo como argumento

-- ============================================================
-- EJEMPLOS DE USO Y CASOS DE PRUEBA
-- ============================================================

-- Funcion auxiliar para mostrar expresiones de forma legible
mostrarExpr :: ASAValues -> String
mostrarExpr (NumV n) = show n
mostrarExpr (AddV e1 e2) = "(+ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (SubV e1 e2) = "(- " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (MultV e1 e2) = "(* " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (DivV e1 e2) = "(/ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"

-- Ejemplos de expresiones para probar
ejemplo1 :: ASAValues
ejemplo1 = AddV (NumV 2) (NumV 3)
-- evalExpr ejemplo1 = 5

ejemplo2 :: ASAValues
ejemplo2 = MultV (AddV (NumV 3) (NumV 4)) (SubV (NumV 10) (NumV 2))
-- evalExpr ejemplo2 = 56

ejemplo3 :: ASAValues
ejemplo3 = DivV (MultV (NumV 20) (NumV 3)) (AddV (NumV 5) (NumV 5))
-- evalExpr ejemplo3 = 6

ejemplo4 :: ASAValues
ejemplo4 = AddV (MultV (NumV 2) (NumV 5)) (DivV (NumV 100) (SubV (NumV 30) (NumV 10)))
-- evalExpr ejemplo4 = 15

-- Funcion de prueba para demostrar el evaluador
-- (Descomentar la linea siguiente para hacer este modulo ejecutable)
main :: IO ()
main = do
    putStrLn "=========================================="
    putStrLn "EVALUADOR DE EXPRESIONES CON COMBINADOR Y"
    putStrLn "=========================================="
    putStrLn ""

    putStrLn "EJEMPLO 1: Suma simple"
    putStrLn $ "  Expresion: " ++ mostrarExpr ejemplo1
    putStrLn $ "  Resultado: " ++ show (evalExpr ejemplo1)
    putStrLn ""

    putStrLn "EJEMPLO 2: Expresion anidada"
    putStrLn $ "  Expresion: " ++ mostrarExpr ejemplo2
    putStrLn $ "  Resultado: " ++ show (evalExpr ejemplo2)
    putStrLn ""

    putStrLn "EJEMPLO 3: Division anidada"
    putStrLn $ "  Expresion: " ++ mostrarExpr ejemplo3
    putStrLn $ "  Resultado: " ++ show (evalExpr ejemplo3)
    putStrLn ""

    putStrLn "EJEMPLO 4: Expresion compleja"
    putStrLn $ "  Expresion: " ++ mostrarExpr ejemplo4
    putStrLn $ "  Resultado: " ++ show (evalExpr ejemplo4)
    putStrLn ""

    putStrLn "=========================================="
    putStrLn "OBSERVACIONES:"
    putStrLn "- evalMaker NUNCA se llama a si misma"
    putStrLn "- La recursion viene del combinador Y"
    putStrLn "- Propiedad: evalExpr = evalMaker evalExpr"
    putStrLn "=========================================="

-- Para ejecutar este modulo como programa principal:
-- 1. Cambiar "module Evaluator where" a "module Main where"
-- 2. Descomentar "main :: IO ()" arriba y cambiar pruebaEvaluador a main
-- 3. Compilar: ghc -o evaluador Evaluator.hs
-- 4. Ejecutar: ./evaluador
