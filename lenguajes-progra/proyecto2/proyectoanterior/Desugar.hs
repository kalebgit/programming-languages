module Desugar where

import Grammars

data ASAValues
    = IdV String
    | NumV Int
    | BooleanV Bool
        -- ==================
        -- aritmeticos
        -- ==================
    | AddV ASAValues ASAValues
    | SubV ASAValues ASAValues
    | MultV ASAValues ASAValues
    | DivV ASAValues ASAValues
    | ExpV ASAValues ASAValues
    | SqrV ASAValues
        -- ==================
        -- logicos
        -- ==================
    | AndV ASAValues ASAValues
    | NotV ASAValues
    | IfV ASAValues ASAValues ASAValues
        -- ==================
        -- comparadores 
        --  ponemos que significa cada uno para que no haya confusiones
        -- ==================
    | EqV ASAValues ASAValues
    | LtV ASAValues ASAValues
    | GtV ASAValues ASAValues
    | LeqV ASAValues ASAValues
    | GeqV ASAValues ASAValues
    | NeqV ASAValues ASAValues
        -- ==================
        -- pares ordenados
        -- ==================
    | PairV ASAValues ASAValues
    | FstV ASAValues
    | SndV ASAValues

        -- ==================
        -- listas
        -- ==================
    | NilV
    | ConsV ASAValues ASAValues
    | HeadV ASAValues
    | TailV ASAValues
        --cosas con let
    | FunV String ASAValues
    | ClosureV String ASAValues [(String, ASAValues)]    
    | AppV ASAValues ASAValues
    deriving (Show)



-- Función auxiliar para operaciones variádicas binarias
desugarBinary :: (ASAValues -> ASAValues -> ASAValues) -> [ASA] -> Maybe ASAValues
desugarBinary _ [] = Nothing
desugarBinary _ [_] = Nothing  -- como necesitamos al menos dos argumentso devolvemos nada (TODO: no se si esta bien implementado esto)
desugarBinary op [x, y] = Just (op (desugar x) (desugar y)) -- necesitamos poner parentesis para indicar que todo eso va dentro del Just
desugarBinary op (x:xs) = case desugarBinary op xs of
    Just inner_expression -> Just (op (desugar x) inner_expression) --es decir que vamosm poniendo todas las expresiones resultas dentro del op
    Nothing -> Nothing



--algunas operaciones queremos asociarlas a la izquierda, entonces: 
-- Desazucariza operaciones binarias con asociatividad a la izquierda
-- Ej: (op a b c) → ((a op b) op c)
desugarBinaryLeft :: (ASAValues -> ASAValues -> ASAValues) -> [ASA] -> ASAValues
desugarBinaryLeft _ []  = error "Operación binaria requiere al menos 2 argumentos"
desugarBinaryLeft _ [_] = error "Operación binaria requiere al menos 2 argumentos"
desugarBinaryLeft op (x:xs) = foldl (\acc e -> op acc (desugar e)) (desugar x) xs



desugarBinaryCompare :: (ASAValues -> ASAValues -> ASAValues) -> [ASA] -> ASAValues
desugarBinaryCompare _ [] = error "Comparador requiere al menos 2 argumentos" -- como necesitamos al menos dos argumentso devolvemos nada (TODO: no se si esta bien implementado esto)
desugarBinaryCompare _ [_] = error "Comparador requiere al menos 2 argumentos"
desugarBinaryCompare op [x, y] = op (desugar x) (desugar y)
--en este caso queremos transformarlo a un AndV con lista de paraemtros y su longitud al menos debe ser 3, pues con 2 solo regresa el 
-- la operacion normal
desugarBinaryCompare op (expr1:expr2:expr3:rest) =
        --aqui ya desazucarizamos el elemento a la derecha
    -- queremos que cuando tenga Lt [1, 2, 3, 4]
    -- se resuelva a AndV [(LtV (NumV 1) (NumV 2)), (LtV (NumV 2) (NumV 3)), ...]
    AndV
        (op (desugar expr1) (desugar expr2))
        (desugarBinaryCompare op (expr2:expr3:rest))



-- Función auxiliar para operaciones variádicas unarias
-- Vemos que en la defincion del primer argumetno de la funcion es de tipo unaria
desugarUnary :: (ASAValues -> ASAValues) -> [ASA] -> ASAValues
desugarUnary _ [] = NilV
desugarUnary op (x:xs) = ConsV (op (desugar x)) (desugarUnary op xs) -- le ponemos parentesis pues en el core las listas son ConsV a1 (ConV a2 (NilV))



desugar :: ASA -> ASAValues
desugar (Num n) = NumV n
desugar (Boolean b) = BooleanV b
desugar (Var x) = IdV x

-- ==================
-- aritméticos
-- ==================
desugar (Add exprs) = case desugarBinary AddV exprs of
    Just result -> result
    Nothing -> error "Add requiere al menos 2 argumentos"




desugar (Sub exprs) = case exprs of
    [x] -> desugar (Mult [Num (-1), x])  -- unary minus
    _   -> desugarBinaryLeft SubV exprs






desugar (Mult exprs) = case desugarBinary MultV exprs of
    Just result -> result
    Nothing -> error "Mult requiere al menos 2 argumentos"





desugar (Div exprs) = desugarBinaryLeft DivV exprs








-- add1 y sub1: operaciones "unarias" que se aplican elemento por elemento
desugar (Add1 exprs) = case exprs of
  [x] -> AddV (desugar x) (NumV 1)                          -- notese que acá se toma en cuenta este caso pues se piensa que cuando solo
                                                            --  se pase un argumeno, entonces devuelva un numero y no una lista
  other -> desugarUnary (\val -> AddV val (NumV 1)) exprs   

desugar (Sub1 exprs) = case exprs of      -- notese que  acá no checamos el caso de la lista vacia, por lo que si le pasamos la lista
                                          -- vacia, etonces regresaria NilV
  [x] -> SubV (desugar x) (NumV 1)
  other -> desugarUnary (\val -> SubV val (NumV 1)) exprs

  

desugar (Sqrt exprs) = case exprs of
  [] -> error "no se dan argumnetos" -- el desugarUnary no maneja los casos cuando se le pasa algun argumento vacío
  [x] -> SqrV (desugar x)
  other -> desugarUnary (\val -> SqrV val) exprs

desugar (Expt e exprs) = case exprs of
  [] -> error "faltan argumentos"  
  [x] -> ExpV (desugar e) (desugar x)
  other -> desugarUnary (\val -> ExpV val (desugar e)) exprs

-- ==================
-- comparadores
-- ==================


desugar (Eq exprs) = case desugarBinaryCompare EqV exprs of
    result -> result

desugar (Lt exprs) = case desugarBinaryCompare LtV exprs of
    result -> result

desugar (Gt exprs) = case desugarBinaryCompare GtV exprs of
    result -> result

desugar (Leq exprs) = case desugarBinaryCompare LeqV exprs of
    result -> result

desugar (Geq exprs) = case desugarBinaryCompare GeqV exprs of
    result -> result

desugar (Neq exprs) = case desugarBinaryCompare NeqV exprs of
    result -> result




-- ==================
-- lógicos
-- ==================
desugar (Not expr) = NotV (desugar expr)

desugar (If cond thenExpr elseExpr) = IfV (desugar cond) (desugar thenExpr) (desugar elseExpr)


--el and que faltaba para reducir los operadores de comparacion
desugar (And exprs) = case desugarBinary AndV exprs of
    Just result -> result
    Nothing -> error "And requiere al menos 2 argumentos"

-- ==================
-- pares ordenados
-- ==================
desugar (Pair e1 e2) = PairV (desugar e1) (desugar e2)

desugar (Fst expr) = FstV (desugar expr)

desugar (Snd expr) = SndV (desugar expr)

-- ==================
-- listas
-- ==================
desugar (List []) = NilV
desugar (List (x:xs)) = ConsV (desugar x) (desugar (List xs))


desugar (Conc e l) = desugarConc e l


-- Núcleo de listas
desugar (Head expr) = HeadV (desugar expr)
desugar (Tail expr) = TailV (desugar expr)


-- ==================
-- funciones
-- ==================
desugar (CondElse p c) = case p of
  [(x,y)] -> desugar (If x y c)
  x:xs -> case x of
    (a,b) -> desugar (If a b (CondElse xs c))

desugar (LetStar bindings body) = desugarLetSec bindings body

desugar (Let bindings body) = desugarLet bindings body

desugar (LetRec bindings body) = desugarLetRec bindings body

desugar (Lambda p c) = desugarLambda p (desugar c)

desugar (App f p)  = case p of
  [] -> error "se necesita almnos un argumento"
  other -> desugarApp (desugar f) p -- este aun esta pendiente



--Funcion auxiliar para la lambda
desugarLambda :: [String] -> ASAValues -> ASAValues
desugarLambda [] c = c
desugarLambda (x:xs) c = FunV x (desugarLambda xs c)

desugarApp :: ASAValues -> [ASA] -> ASAValues
desugarApp ac [] = ac
desugarApp ac (x:xs) = desugarApp (AppV ac (desugar x)) xs


desugarLetSec :: [(String, ASA)] -> ASA -> ASAValues
-- Caso base: Si no hay variables a enlazar, desazucara el cuerpo.
desugarLetSec [] body = desugar body
-- Caso Recursivo (Múltiples Enlaces):
-- Transforma: (let ((var expr) : rest) body) -> ((lambda var (desugarLet rest body)) (desugar expr))
desugarLetSec ((var, expr):rest) body =
    -- 1. Se construye el cuerpo interno recursivamente: (desugarLet rest body)
    --    Esto resuelve los enlaces restantes de 'rest'.
    AppV
        -- 2. La función (f): (lambda var (desugarLet rest body))
        (FunV var (desugarLetSec rest body))
        -- 3. El argumento (p): (desugar expr)
        (desugar expr)



desugarLet :: [(String, ASA)] -> ASA -> ASAValues
desugarLet bindings body =
        -- 1. Separar las variables de las expresiones.
      desugar (App (Lambda (map fst bindings) body) (map snd bindings) )
        


-- La clave es esta desazucaración:
-- (letrec ((var val)) body)  ->  (let ((var (App zCombinador [Lambda [var] val]))) body)

-- desugarLetRec :: [(String, ASA)] -> ASA -> ASAValues
-- desugarLetRec [(var,val)] body = desugar (Let [(var,(App zCombinador [Lambda [var] val]) )] body)
-- desugarLetRec _ _ = error "aun no implementado"

desugarLetRec :: [(String, ASA)] -> ASA -> ASAValues
desugarLetRec bindings body =
    desugar (Let (map (\(var, val) -> (var, App zCombinador [Lambda [var] val])) bindings) body) 



-- correccion de listas
desugarConc :: ASA -> ASA -> ASAValues
desugarConc e l = case (desugar e, desugar l) of
    (NilV, list) -> list
    (elem, NilV) -> ConsV elem NilV
    (elem, list) -> ConsV elem list



-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
   -- Combinador Z pa
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========

-- Tipo de datos auxiliar para el Combinador Z (solo para claridad)
-- Termino interno: (lambda x (App (Var "f") (Lambda ["v"] (App (App (Var "x") [Var "x"]) [Var "v"]))))
internalTerm :: ASA
internalTerm = Lambda ["x"] $ App (Var "f") [ Lambda ["v"] $ App (App (Var "x") [Var "x"]) [Var "v"] ]

-- Y (x x v) se traduce a (App (App (Var "x") [Var "x"]) [Var "v"])




zCombinador :: ASA
zCombinador = Lambda ["f"] $ App internalTerm [internalTerm]

-- notese que al combinador Z lo construimos como ASA ya que este se puede desasucarizar como un let.
