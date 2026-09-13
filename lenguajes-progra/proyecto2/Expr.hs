module Expr where

-- Tipo de datos para expresiones aritmeticas en el nucleo
data ASAValues
    = NumV Int                    -- Numero entero
    | AddV ASAValues ASAValues    -- Suma
    | SubV ASAValues ASAValues    -- Resta
    | MultV ASAValues ASAValues   -- Multiplicacion
    | DivV ASAValues ASAValues    -- Division
    deriving (Show, Eq)
