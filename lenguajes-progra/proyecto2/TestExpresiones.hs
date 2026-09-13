module Main where

import Expr
import YCombinator
import Evaluator

-- Funcion para mostrar expresiones de forma legible
mostrarExpr :: ASAValues -> String
mostrarExpr (NumV n) = show n
mostrarExpr (AddV e1 e2) = "(+ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (SubV e1 e2) = "(- " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (MultV e1 e2) = "(* " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"
mostrarExpr (DivV e1 e2) = "(/ " ++ mostrarExpr e1 ++ " " ++ mostrarExpr e2 ++ ")"

-- Version instrumentada de evalMaker para mostrar los pasos
evalMakerTraza :: Int -> (ASAValues -> Int) -> (ASAValues -> Int)
evalMakerTraza nivel evalRec expr =
    let indent = replicate (nivel * 2) ' '
        resultado = case expr of
            NumV n -> n
            AddV e1 e2 ->
                let v1 = evalRec e1
                    v2 = evalRec e2
                in v1 + v2
            SubV e1 e2 ->
                let v1 = evalRec e1
                    v2 = evalRec e2
                in v1 - v2
            MultV e1 e2 ->
                let v1 = evalRec e1
                    v2 = evalRec e2
                in v1 * v2
            DivV e1 e2 ->
                let v1 = evalRec e1
                    v2 = evalRec e2
                in if v2 == 0
                   then error "Division por cero"
                   else v1 `div` v2
    in resultado

main :: IO ()
main = do
    putStrLn "=========================================="
    putStrLn "TEST: EVALUACION DE EXPRESIONES ARITMETICAS"
    putStrLn "CON COMBINADOR Y"
    putStrLn "=========================================="
    putStrLn ""

    -- Test 1: Expresion simple
    putStrLn "TEST 1: Expresion simple"
    putStrLn "========================"
    let expr1 = AddV (NumV 2) (NumV 3)
    putStrLn $ "Expresion: " ++ mostrarExpr expr1
    putStrLn $ "Resultado: " ++ show (evalExpr expr1)
    putStrLn ""
    putStrLn "Expansion paso a paso:"
    putStrLn "  evalExpr (+ 2 3)"
    putStrLn "  = (yFix evalMaker) (+ 2 3)"
    putStrLn "  = (evalMaker evalExpr) (+ 2 3)    [por punto fijo]"
    putStrLn "  = evalExpr 2 + evalExpr 3          [evalMaker usa evalExpr recursivamente]"
    putStrLn "  = 2 + 3"
    putStrLn "  = 5"
    putStrLn ""

    -- Test 2: Expresion anidada
    putStrLn "TEST 2: Expresion anidada"
    putStrLn "=========================="
    let expr2 = MultV (AddV (NumV 3) (NumV 4)) (SubV (NumV 10) (NumV 2))
    putStrLn $ "Expresion: " ++ mostrarExpr expr2
    putStrLn $ "Resultado: " ++ show (evalExpr expr2)
    putStrLn ""
    putStrLn "Expansion paso a paso:"
    putStrLn "  evalExpr (* (+ 3 4) (- 10 2))"
    putStrLn "  = (evalMaker evalExpr) (* (+ 3 4) (- 10 2))"
    putStrLn "  = evalExpr (+ 3 4) * evalExpr (- 10 2)    [evalMaker expande]"
    putStrLn "  = ((evalMaker evalExpr) (+ 3 4)) * ((evalMaker evalExpr) (- 10 2))"
    putStrLn "  = (evalExpr 3 + evalExpr 4) * (evalExpr 10 - evalExpr 2)"
    putStrLn "  = (3 + 4) * (10 - 2)"
    putStrLn "  = 7 * 8"
    putStrLn "  = 56"
    putStrLn ""

    -- Test 3: Con division
    putStrLn "TEST 3: Con division"
    putStrLn "===================="
    let expr3 = DivV (MultV (NumV 20) (NumV 3)) (AddV (NumV 5) (NumV 5))
    putStrLn $ "Expresion: " ++ mostrarExpr expr3
    putStrLn $ "Resultado: " ++ show (evalExpr expr3)
    putStrLn ""
    putStrLn "Expansion paso a paso:"
    putStrLn "  evalExpr (/ (* 20 3) (+ 5 5))"
    putStrLn "  = (evalMaker evalExpr) (/ (* 20 3) (+ 5 5))"
    putStrLn "  = evalExpr (* 20 3) `div` evalExpr (+ 5 5)"
    putStrLn "  = (evalExpr 20 * evalExpr 3) `div` (evalExpr 5 + evalExpr 5)"
    putStrLn "  = (20 * 3) `div` (5 + 5)"
    putStrLn "  = 60 `div` 10"
    putStrLn "  = 6"
    putStrLn ""

    -- Test 4: Expresion compleja
    putStrLn "TEST 4: Expresion compleja"
    putStrLn "==========================="
    let expr4 = AddV (MultV (NumV 2) (NumV 5)) (DivV (NumV 100) (SubV (NumV 30) (NumV 10)))
    putStrLn $ "Expresion: " ++ mostrarExpr expr4
    putStrLn $ "Resultado: " ++ show (evalExpr expr4)
    putStrLn ""

    putStrLn "=========================================="
    putStrLn "OBSERVACIONES CLAVE:"
    putStrLn "=========================================="
    putStrLn "1. evalMaker NUNCA se llama a si misma por nombre"
    putStrLn "2. La recursion viene del combinador Y via yFix"
    putStrLn "3. Propiedad de punto fijo: evalExpr = evalMaker evalExpr"
    putStrLn "4. En cada paso recursivo, evalMaker usa 'evalRec'"
    putStrLn "5. 'evalRec' es en realidad 'evalExpr' (inyectado por Y)"
    putStrLn "=========================================="
