module Main where

import Expr
import YCombinator

-- El generador del interprete (funcion casi-recursiva)
-- Recibe el interprete como parametro 'self'
interpreteMaker :: (ASAValues -> Int) -> (ASAValues -> Int)
interpreteMaker self expr = case expr of
    -- Casos base
    NumV n -> n

    -- Casos recursivos el interprete se usa a si mismo
    -- para evaluar subexpresiones
    AddV e1 e2 -> self e1 + self e2
    --            El interprete se pasa a si mismo

    SubV e1 e2 -> self e1 - self e2
    MultV e1 e2 -> self e1 * self e2
    DivV e1 e2 ->
        let v2 = self e2
        in if v2 == 0
           then error "Division por cero"
           else self e1 `div` v2

-- El AUTOINTERPRETE se obtiene aplicando Y al generador
interprete :: ASAValues -> Int
interprete = yFix interpreteMaker

-- Propiedad clave es interprete = interpreteMaker interprete
-- Asi el interprete se recibe a si mismo como argumento

-- Funcion de prueba
main :: IO ()
main = do
    putStrLn "=== AUTOINTERPRETE CON COMBINADOR Y ==="
    putStrLn ""

    let expr1 = AddV (NumV 2) (NumV 3)
    putStrLn $ "Expresion 1: (+ 2 3)"
    putStrLn $ "Resultado: " ++ show (interprete expr1)
    putStrLn ""

    let expr2 = MultV (AddV (NumV 3) (NumV 4)) (SubV (NumV 10) (NumV 2))
    putStrLn $ "Expresion 2: (* (+ 3 4) (- 10 2))"
    putStrLn $ "Resultado: " ++ show (interprete expr2)
    putStrLn ""

    let expr3 = DivV (NumV 20) (AddV (NumV 2) (NumV 3))
    putStrLn $ "Expresion 3: (/ 20 (+ 2 3))"
    putStrLn $ "Resultado: " ++ show (interprete expr3)
    putStrLn ""

    putStrLn "Propiedad de autointerpretacion:"
    putStrLn "  interprete = interpreteMaker interprete"
    putStrLn "  El interprete se pasa a si mismo como argumento"
    putStrLn "  Esto es AUTOINTERPRETACION gracias al combinador Y"
