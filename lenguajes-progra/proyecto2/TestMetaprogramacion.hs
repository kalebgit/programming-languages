module Main where

import Expr
import YCombinator

-- ============================================================
-- TESTS FORMALES DE METAPROGRAMACION
-- ============================================================

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

-- METAPROGRAMACION 1: INSPECCION
contieneDivision :: ASAValues -> Bool
contieneDivision expr = case expr of
    NumV _ -> False
    DivV _ _ -> True
    AddV e1 e2 -> contieneDivision e1 || contieneDivision e2
    SubV e1 e2 -> contieneDivision e1 || contieneDivision e2
    MultV e1 e2 -> contieneDivision e1 || contieneDivision e2

evaluacionSegura :: ASAValues -> Maybe Int
evaluacionSegura expr =
    if contieneDivision expr
    then Nothing
    else Just (interprete expr)

-- METAPROGRAMACION 2: OPTIMIZACION
optimizar :: ASAValues -> ASAValues
optimizar expr = case expr of
    NumV n -> NumV n
    AddV e1 e2 ->
        let e1' = optimizar e1
            e2' = optimizar e2
        in case (e1', e2') of
            (NumV 0, e) -> e
            (e, NumV 0) -> e
            _ -> AddV e1' e2'
    SubV e1 e2 -> SubV (optimizar e1) (optimizar e2)
    MultV e1 e2 ->
        let e1' = optimizar e1
            e2' = optimizar e2
        in case (e1', e2') of
            (NumV 0, _) -> NumV 0
            (_, NumV 0) -> NumV 0
            (NumV 1, e) -> e
            (e, NumV 1) -> e
            _ -> MultV e1' e2'
    DivV e1 e2 -> DivV (optimizar e1) (optimizar e2)

evalOptimizado :: ASAValues -> Int
evalOptimizado = interprete . optimizar

-- Utilidades para tests
data TestResult = Pass | Fail String deriving (Eq, Show)

runTest :: String -> Bool -> TestResult
runTest name condition =
    if condition
    then Pass
    else Fail name

main :: IO ()
main = do
    putStrLn "=========================================="
    putStrLn "TESTS FORMALES: METAPROGRAMACION"
    putStrLn "=========================================="
    putStrLn ""

    putStrLn "PARTE 1: TESTS DE INSPECCION DE CODIGO"
    putStrLn "========================================"

    -- Test 1: Detectar division presente
    let test1 = runTest "Test 1: Detectar division en (/ 10 2)"
                        (contieneDivision (DivV (NumV 10) (NumV 2)) == True)
    putStrLn $ "Test 1 - Detectar division presente: " ++ show test1

    -- Test 2: Detectar ausencia de division
    let test2 = runTest "Test 2: No detectar division en (+ 5 3)"
                        (contieneDivision (AddV (NumV 5) (NumV 3)) == False)
    putStrLn $ "Test 2 - Detectar ausencia de division: " ++ show test2

    -- Test 3: Detectar division anidada
    let test3 = runTest "Test 3: Detectar division en (* (/ 10 2) 5)"
                        (contieneDivision (MultV (DivV (NumV 10) (NumV 2))
                                                 (NumV 5)) == True)
    putStrLn $ "Test 3 - Detectar division anidada: " ++ show test3

    -- Test 4: Evaluacion segura sin division
    let test4 = runTest "Test 4: Evaluacion segura de (+ 5 3)"
                        (evaluacionSegura (AddV (NumV 5) (NumV 3)) == Just 8)
    putStrLn $ "Test 4 - Evaluacion segura sin division: " ++ show test4

    -- Test 5: Evaluacion segura con division
    let test5 = runTest "Test 5: Advertencia en (/ 10 2)"
                        (evaluacionSegura (DivV (NumV 10) (NumV 2)) == Nothing)
    putStrLn $ "Test 5 - Advertencia con division: " ++ show test5

    putStrLn ""
    putStrLn "PARTE 2: TESTS DE OPTIMIZACION DE CODIGO"
    putStrLn "=========================================="

    -- Test 6: Optimizar suma con cero
    let test6 = runTest "Test 6: Optimizar (+ 0 5)"
                        (optimizar (AddV (NumV 0) (NumV 5)) == NumV 5)
    putStrLn $ "Test 6 - Optimizar suma con cero: " ++ show test6

    -- Test 7: Optimizar multiplicacion por 1
    let test7 = runTest "Test 7: Optimizar (* 1 7)"
                        (optimizar (MultV (NumV 1) (NumV 7)) == NumV 7)
    putStrLn $ "Test 7 - Optimizar multiplicacion por 1: " ++ show test7

    -- Test 8: Optimizar multiplicacion por 0
    let test8 = runTest "Test 8: Optimizar (* 0 999)"
                        (optimizar (MultV (NumV 0) (NumV 999)) == NumV 0)
    putStrLn $ "Test 8 - Optimizar multiplicacion por 0: " ++ show test8

    -- Test 9: Optimizacion anidada
    let expr9 = AddV (MultV (NumV 0) (NumV 999)) (NumV 5)
    let test9 = runTest "Test 9: Optimizar (+ (* 0 999) 5)"
                        (optimizar expr9 == NumV 5)
    putStrLn $ "Test 9 - Optimizacion anidada: " ++ show test9

    -- Test 10: Verificar que optimizacion preserva resultado
    let expr10 = MultV (AddV (NumV 0) (NumV 7)) (AddV (NumV 3) (NumV 0))
    let test10 = runTest "Test 10: Resultado preservado"
                         (interprete expr10 == evalOptimizado expr10)
    putStrLn $ "Test 10 - Resultado preservado tras optimizacion: " ++ show test10

    -- Test 11: Optimizacion compleja
    let expr11 = AddV (MultV (NumV 1) (NumV 10)) (MultV (NumV 0) (NumV 100))
    let test11 = runTest "Test 11: Optimizacion compleja"
                         (optimizar expr11 == NumV 10)
    putStrLn $ "Test 11 - Optimizacion compleja: " ++ show test11

    -- Test 12: Verificar que todas las optimizaciones preservan resultado
    let expr12 = AddV (MultV (NumV 1) (AddV (NumV 0) (NumV 5)))
                      (MultV (NumV 0) (NumV 1000))
    let test12 = runTest "Test 12: Preservacion de resultado complejo"
                         (interprete expr12 == evalOptimizado expr12 &&
                          evalOptimizado expr12 == 5)
    putStrLn $ "Test 12 - Preservacion resultado complejo: " ++ show test12

    putStrLn ""
    putStrLn "=========================================="

    let allTests = [test1, test2, test3, test4, test5, test6,
                    test7, test8, test9, test10, test11, test12]
    let passedTests = length $ filter (== Pass) allTests
    let totalTests = length allTests

    putStrLn $ "RESULTADO: " ++ show passedTests ++ "/" ++ show totalTests ++ " tests pasados"

    if passedTests == totalTests
    then do
        putStrLn "EXITO: Todos los tests de metaprogramacion pasaron!"
        putStrLn ""
        putStrLn "VERIFICACION DE METAPROGRAMACION:"
        putStrLn "1. INSPECCION:"
        putStrLn "   - El codigo examina su propia estructura"
        putStrLn "   - Detecta caracteristicas antes de ejecutar"
        putStrLn "2. OPTIMIZACION:"
        putStrLn "   - El codigo se transforma a si mismo"
        putStrLn "   - Las transformaciones preservan el resultado"
        putStrLn "   - Mejora la eficiencia eliminando operaciones innecesarias"
        putStrLn ""
        putStrLn "TODO ESTO ES POSIBLE GRACIAS AL COMBINADOR Y"
    else
        putStrLn "ERROR: Algunos tests fallaron"

    putStrLn "=========================================="
