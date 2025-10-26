
--Aca se muestran algunas de las pruebas para verificar errores, hay que 
-- compiar y pegar, aun no las he automatizado jeje

interp (desugar(Grammars.parser(Lex.lexer"((lambda (x y z) (+ x y z)) 3 5 -8)"))) []
-- NumV 0
interp( desugar(Grammars.parser(Lex.lexer"(+ (let (x 3) (+ x 2)) 4)"))) []
--NumV 9
interp( desugar(Grammars.parser(Lex.lexer"(+ (let (x 3) (+ x 2)) x)"))) [] 
-- error
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

--(let ( sum_n (lambda (n) (if (= n 0) 0 (+ n (sum_n (- n 1))) ) )  ) (sum_n 100) )
(let ( (sum-n (lambda (n) (if (= n 0) 0 (+ n (sum-n (- n 1))) ) ) ) ) (sum-n 100) )

(lambda (s) (lambda (n) (if (= n 0) 0 (+ n (s (- n 1)))  ) ) ) 100