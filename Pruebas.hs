
--Aca se muestran algunas de las pruebas para verificar errores, hay que 
-- compiar y pegar, aun no las he automatizado jeje


-- Para las siguintes reglas con que ejecutes en la terminal: ghci It_Minilisp

interp (desugar(Grammars.parser(Lex.lexer"((lambda (x y z) (+ x y z)) 3 5 -8)"))) []
-- NumV 0
interp( desugar(Grammars.parser(Lex.lexer"(+ (let (x 3) (+ x 2)) 4)"))) []
--NumV 9
interp( desugar(Grammars.parser(Lex.lexer"(+ (let (x 3) (+ x 2)) x)"))) []
-- error

-- para estas prubebas ejecuta run dentro de tu entorno de It_Minilisp y copia y pegacada una

(let ((x 2)(y 5)(z 2)) (+ x y z))

(let (a 10) (let (b (* a 5)) (+ a b 2)))
-- 62
(let (f (lambda (x) (* x x))) (f 7))
-- 49
(let (a 6) (let (f (lambda (x) (+ x a))) (let (c (f 4)) (let (g (lambda (y) (* y 3))) (g c)))))
-- 30
(let (p 4) (let (q 2) (let (r (/ p q)) (let (s (lambda (x) (- x 1))) (* (s p) (+ r q))))))
-- 12
(let (a 5) (let (b (+ a 2)) (let (f (lambda (x) (+ x a))) (let (g (lambda (y) (* y b))) (let (h (lambda (p q) (+ (f p) (g q)))) (let (c (f b)) (let (d (g a)) (let (u (+ c d)) (let (v (* (h a b) 2)) (let (w (+ u v)) (let (x (+ (h 3 4) w)) (let (y (+ x b)) (let (z (+ y b)) (+ w y))))))))))) )))

-- suma de los primeros naturales
(letrec ( sum_n (lambda (n) (if (= n 0) 0 (+ n (sum_n (- n 1))) ) ) ) (sum_n 100) )

-- fac de 5
(letrec ((fac (lambda (n) (if (= n 0) 1 (* n (fac (sub1 n))))))) (fac 5))

-- fibo de 5
(letrec ((fib (lambda (n) (if (<= n 1) n (+ (fib (sub1 n)) (fib (- n 2))))))) (fib 5))

-- funcion map, en este caso lo que hace es elevar al cuadrado
(letrec ((map (lambda (n) (if (= n []) [] (++ ( (lambda (x) (* x x)) (head n)) (map (tail n))))))) (map [1,2,3]))

-- filter
(letrec ((filter (lambda (n) (if (= n []) [] (++ ( if (< (head n) 8) [] (head n) ) (filter (tail n))) )))) (filter [1,6,3,12,23,7]))

(cond [(< 2 (+ 4 5)) 3] else (+ 3 4))


