module Main where

import Expr
import YCombinator

-- ============================================================
-- TESTS FORMALES DE AUTOINTERPRETACION
-- ============================================================

-- El "generador" del interprete (funcion casi-recursiva)
-- Recibe el interprete como parametro 'self'
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

-- El AUTOINTERPRETE: se obtiene aplicando Y al generador
interprete :: ASAValues -> Int
interprete = yFix interpreteMaker

-- Funcion de test
data TestResult = Pass | Fail String deriving (Eq, Show)

runTest :: String -> Bool -> TestResult
runTest name condition =
    if condition
    then Pass
    else Fail name

main :: IO ()
main = do
    putStrLn "=========================================="
    putStrLn "TESTS FORMALES: AUTOINTERPRETACION"
    putStrLn "=========================================="
    putStrLn ""

    -- Test 1: Numeros simples
    let test1 = runTest "Test 1: NumV 5"
                        (interprete (NumV 5) == 5)
    putStrLn $ "Test 1 - Numeros simples: " ++ show test1

    -- Test 2: Suma simple
    let test2 = runTest "Test 2: (+ 2 3)"
                        (interprete (AddV (NumV 2) (NumV 3)) == 5)
    putStrLn $ "Test 2 - Suma simple: " ++ show test2

    -- Test 3: Resta
    let test3 = runTest "Test 3: (- 10 4)"
                        (interprete (SubV (NumV 10) (NumV 4)) == 6)
    putStrLn $ "Test 3 - Resta: " ++ show test3

    -- Test 4: Multiplicacion
    let test4 = runTest "Test 4: (* 7 8)"
                        (interprete (MultV (NumV 7) (NumV 8)) == 56)
    putStrLn $ "Test 4 - Multiplicacion: " ++ show test4

    -- Test 5: Division
    let test5 = runTest "Test 5: (/ 20 4)"
                        (interprete (DivV (NumV 20) (NumV 4)) == 5)
    putStrLn $ "Test 5 - Division: " ++ show test5

    -- Test 6: Expresion anidada
    let test6 = runTest "Test 6: (+ (* 3 4) 5)"
                        (interprete (AddV (MultV (NumV 3) (NumV 4)) (NumV 5)) == 17)
    putStrLn $ "Test 6 - Expresion anidada: " ++ show test6

    -- Test 7: Expresion compleja
    let test7 = runTest "Test 7: (* (+ 3 4) (- 10 2))"
                        (interprete (MultV (AddV (NumV 3) (NumV 4))
                                           (SubV (NumV 10) (NumV 2))) == 56)
    putStrLn $ "Test 7 - Expresion compleja: " ++ show test7

    -- Test 8: Division anidada
    let test8 = runTest "Test 8: (/ (* 20 3) (+ 5 5))"
                        (interprete (DivV (MultV (NumV 20) (NumV 3))
                                          (AddV (NumV 5) (NumV 5))) == 6)
    putStrLn $ "Test 8 - Division anidada: " ++ show test8

    -- Test 9: Verificar autointerpretacion
    -- El interprete se usa a si mismo para evaluar subexpresiones
    let expr9 = AddV (NumV 10) (NumV 20)
    let result9a = interprete expr9
    let result9b = interpreteMaker interprete expr9  -- Verificar punto fijo
    let test9 = runTest "Test 9: Propiedad de punto fijo"
                        (result9a == result9b)
    putStrLn $ "Test 9 - Punto fijo (interprete = interpreteMaker interprete): " ++ show test9

    -- Test 10: Expresion muy anidada
    let test10 = runTest "Test 10: Expresion muy anidada"
                         (interprete (AddV (MultV (AddV (NumV 2) (NumV 3))
                                                  (SubV (NumV 10) (NumV 5)))
                                           (DivV (NumV 100) (NumV 10))) == 35)
    putStrLn $ "Test 10 - Expresion muy anidada: " ++ show test10

    putStrLn ""
    putStrLn "=========================================="

    let allTests = [test1, test2, test3, test4, test5,
                    test6, test7, test8, test9, test10]
    let passedTests = length $ filter (== Pass) allTests
    let totalTests = length allTests

    putStrLn $ "RESULTADO: " ++ show passedTests ++ "/" ++ show totalTests ++ " tests pasados"

    if passedTests == totalTests
    then do
        putStrLn "EXITO: Todos los tests de autointerpretacion pasaron!"
        putStrLn ""
        putStrLn "VERIFICACION DE AUTOINTERPRETACION:"
        putStrLn "- El interprete se pasa a si mismo como argumento"
        putStrLn "- Propiedad: interprete = interpreteMaker interprete"
        putStrLn "- NO hay auto-referencia por nombre"
        putStrLn "- La recursion viene del combinador Y"
    else
        putStrLn "ERROR: Algunos tests fallaron"

    putStrLn "=========================================="
