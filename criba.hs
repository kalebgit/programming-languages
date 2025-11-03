-- numeros natualres
zeroFunc :: (a -> a) -> a -> a
zeroFunc = \s x -> x

succFunc n = \s x -> s (n s x)

--busque la definicion de las listas con calculo labmda
nilFunc :: b -> b
nilFunc n = n

consFunc h t = \c n -> c h (t c n)

headFunc :: ((a -> b -> a) -> b -> c) -> c
headFunc l = l (\h t -> h) (error "empty list")

tailFunc l = l (\x p -> p) id

-- es una funcion que se usara para filtarar elemento por elemnto
filterFunc :: (a -> Bool) -> [a] -> [a]
filterFunc p [] = []
filterFunc p (x:xs) = if p x then x : filterFunc p xs else filterFunc p xs

-- modulo y saber cuando es multiplo
noMultiploFunc :: Int -> Int -> Bool
noMultiploFunc n m = m `mod` n /= 0

-- criba
cribaFunc :: [Int] -> [Int]
cribaFunc [] = []
cribaFunc (p:xs) = p : cribaFunc (filterFunc (noMultiploFunc p) xs)

-- genermos la lista
fromFunc :: Int -> [Int]
fromFunc n = n : fromFunc (n + 1)

primesFunc :: [Int]
primesFunc = cribaFunc (fromFunc 2)

main :: IO ()
main = do
    print (take 10 primesFunc)

--poner el terminal runhaskell criba.hs para ver los numeros mipresos