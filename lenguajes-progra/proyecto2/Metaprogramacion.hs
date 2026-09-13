module Main where

import Expr
import YCombinator

-- Autointerprete base
interpreteMaker :: (ASAValues -> Int) -> (ASAValues -> Int)
interpreteMaker self expr = case expr of
    NumV n -> n
    AddV e1 e2 -> self e1 + self e2
    SubV e1 e2 -> self e1 - self e2
    MultV e1 e2 -> self e1 * self e2
    DivV e1 e2 ->
        let v2 = self e2
        in if v2 == 0
           then error "Division por cero"
           else self e1 `div` v2

interprete :: ASAValues -> Int
interprete = yFix interpreteMaker

-- ============================================================
-- METAPROGRAMACION 1: INSPECCION DE CODIGO
-- ============================================================

-- El programa puede examinar su propia estructura
contieneDivision :: ASAValues -> Bool
contieneDivision expr = case expr of
    NumV _ -> False
    DivV _ _ -> True  -- Encontro una division
    AddV e1 e2 -> contieneDivision e1 || contieneDivision e2
    SubV e1 e2 -> contieneDivision e1 || contieneDivision e2
    MultV e1 e2 -> contieneDivision e1 || contieneDivision e2

-- Uso: detectar si una expresion tiene divisiones
-- antes de evaluarla para advertir al usuario
evaluacionSegura :: ASAValues -> Maybe Int
evaluacionSegura expr =
    if contieneDivision expr
    then Nothing  -- Advertir: contiene division potencialmente peligrosa
    else Just (interprete expr)

-- ============================================================
-- METAPROGRAMACION 2: OPTIMIZACION DE CODIGO
-- ============================================================

-- El programa puede reescribirse a si mismo
optimizar :: ASAValues -> ASAValues
optimizar expr = case expr of
    -- Optimizacion: eliminar sumas con cero
    AddV (NumV 0) e -> optimizar e
    AddV e (NumV 0) -> optimizar e

    -- Optimizacion: eliminar multiplicaciones por 1
    MultV (NumV 1) e -> optimizar e
    MultV e (NumV 1) -> optimizar e

    -- Optimizacion: multiplicacion por 0 = 0
    MultV (NumV 0) _ -> NumV 0
    MultV _ (NumV 0) -> NumV 0

    -- Recursivamente optimizar subexpresiones
    AddV e1 e2 -> AddV (optimizar e1) (optimizar e2)
    SubV e1 e2 -> SubV (optimizar e1) (optimizar e2)
    MultV e1 e2 -> MultV (optimizar e1) (optimizar e2)
    DivV e1 e2 -> DivV (optimizar e1) (optimizar e2)

    -- Caso base
    NumV n -> NumV n

-- Pipeline de metaprogramacion: optimizar antes de evaluar
evalOptimizado :: ASAValues -> Int
evalOptimizado = interprete . optimizar

-- ============================================================
-- FUNCIONES DE PRUEBA
-- ============================================================

mostrarExpr :: ASAValues -> String
mostrarExpr (NumV n) = show n
mostrarExpr (AddV e1 e2) = "(+ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (SubV e1 e2) = "(- " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (MultV e1 e2) = "(* " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (DivV e1 e2) = "(/ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"

main :: IO ()
main = do
    putStrLn "=========================================="
    putStrLn "METAPROGRAMACION CON COMBINADOR Y"
    putStrLn "=========================================="
    putStrLn ""

    -- INSPECCION DE CODIGO
    putStrLn "1. INSPECCION DE CODIGO"
    putStrLn "===================="

    let expr1 = AddV (NumV 5) (NumV 3)
    putStrLn $ "Expresion: " ++ mostrarExpr expr1
    putStrLn $ "Contiene division? " ++ show (contieneDivision expr1)
    case evaluacionSegura expr1 of
        Just val -> putStrLn $ "Evaluacion segura: " ++ show val
        Nothing -> putStrLn "ADVERTENCIA: Contiene division"
    putStrLn ""

    let expr2 = DivV (NumV 10) (NumV 2)
    putStrLn $ "Expresion: " ++ mostrarExpr expr2
    putStrLn $ "Contiene division? " ++ show (contieneDivision expr2)
    case evaluacionSegura expr2 of
        Just val -> putStrLn $ "Evaluacion segura: " ++ show val
        Nothing -> putStrLn "ADVERTENCIA: Contiene division"
    putStrLn ""

    -- OPTIMIZACION DE CODIGO
    putStrLn "2. OPTIMIZACION DE CODIGO"
    putStrLn "======================"

    let expr3 = AddV (MultV (NumV 0) (NumV 999)) (NumV 5)
    putStrLn $ "Expresion original: " ++ mostrarExpr expr3
    putStrLn $ "Expresion optimizada: " ++ mostrarExpr (optimizar expr3)
    putStrLn $ "Resultado sin optimizar: " ++ show (interprete expr3)
    putStrLn $ "Resultado optimizado: " ++ show (evalOptimizado expr3)
    putStrLn ""

    let expr4 = MultV (AddV (NumV 0) (NumV 7)) (AddV (NumV 3) (NumV 0))
    putStrLn $ "Expresion original: " ++ mostrarExpr expr4
    putStrLn $ "Expresion optimizada: " ++ mostrarExpr (optimizar expr4)
    putStrLn $ "Resultado sin optimizar: " ++ show (interprete expr4)
    putStrLn $ "Resultado optimizado: " ++ show (evalOptimizado expr4)
    putStrLn ""

    let expr5 = AddV (MultV (NumV 1) (NumV 10)) (MultV (NumV 0) (NumV 100))
    putStrLn $ "Expresion original: " ++ mostrarExpr expr5
    putStrLn $ "Expresion optimizada: " ++ mostrarExpr (optimizar expr5)
    putStrLn $ "Resultado sin optimizar: " ++ show (interprete expr5)
    putStrLn $ "Resultado optimizado: " ++ show (evalOptimizado expr5)
    putStrLn ""

    putStrLn "=========================================="
    putStrLn "CONCLUSIONES:"
    putStrLn "- El codigo puede INSPECCIONARSE a si mismo"
    putStrLn "- El codigo puede TRANSFORMARSE a si mismo"
    putStrLn "- Esto es METAPROGRAMACION habilitada por el combinador Y"
    putStrLn "=========================================="
