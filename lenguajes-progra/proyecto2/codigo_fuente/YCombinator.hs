module YCombinator where

-- Combinador Y (combinador de punto fijo)
-- Version practica para Haskell con evaluacion perezosa
--
-- Y = λf. (λx. f (x x)) (λx. f (x x))
--
-- En Haskell, gracias a la evaluacion perezosa, podemos usar
-- la forma mas simple: yFix f = f (yFix f)
-- es decir la que vimos en clase
--
-- Esta funcion toma una funcion casi-recursiva y retorna
-- su punto fijo, permitiendo recursion sin autorreferencia.

yFix :: ((a -> b) -> (a -> b)) -> (a -> b)
yFix f = f (yFix f)
