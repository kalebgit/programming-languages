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
      -- ==================
    -- logicos
    -- ==================
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

-- Función auxiliar para operaciones variádicas unarias
-- Vemos que en la defincion del primer argumetno de la funcion es de tipo unaria
desugarUnary :: (ASAValues -> ASAValues) -> [ASA] -> ASAValues
desugarUnary _ [] = NilV
--NOTA SOBRE HASKELL: al especificar llamadas de funcion por default se agregan los parentesis alrededor del resultado de esa llamada a fucnion
-- como con desugar x se le preservaran los parentesis op (resultado_desugar)
desugarUnary op (x:xs) = ConsV (op (desugar x)) (desugarUnary op xs) -- le ponemos parentesis pues en el core las listas son ConsV a1 (ConV a2 (NilV))
-- desugarUnary _ _ = Nothing  -- creo que no es necesario porque grammars siempre crea un arreglo



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

desugar (Sub exprs) = case desugarBinary SubV exprs of
    Just result -> result
    Nothing -> error "Sub requiere al menos 2 argumentos"

desugar (Mult exprs) = case desugarBinary MultV exprs of
    Just result -> result
    Nothing -> error "Mult requiere al menos 2 argumentos"

desugar (Div exprs) = case desugarBinary DivV exprs of
    Just result -> result
    Nothing -> error "Div requiere al menos 2 argumentos"


--TODO: verificar que funciona correctamente es decir que la funcion lambad anonima se llame en cada elemento de la lista
-- add1 y sub1: operaciones "unarias" que se aplican elemento por elemento
desugar (Add1 exprs) = desugarUnary (\val -> AddV val (NumV 1)) exprs

desugar (Sub1 exprs) = desugarUnary (\val -> SubV val (NumV 1)) exprs

-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
    -- FALTA AGREGAR EXPT Y SQRT A LOS ASAS
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
desugar (Sqrt exprs) = desugarUnary (\val -> error "Sqrt no implementado aún en el núcleo") exprs

desugar (Expt [base, exp]) = error "Expt no implementado aún"
-- TODO: Agregar ExptV a ASAValues
desugar (Expt _) = error "Expt requiere exactamente 2 argumentos"

-- ==================
-- comparadores
-- ==================
desugar (Eq exprs) = case desugarBinary EqV exprs of
    Just result -> result
    Nothing -> error "Eq requiere al menos 2 argumentos"

desugar (Lt exprs) = case desugarBinary LtV exprs of
    Just result -> result
    Nothing -> error "Lt requiere al menos 2 argumentos"

desugar (Gt exprs) = case desugarBinary GtV exprs of
    Just result -> result
    Nothing -> error "Gt requiere al menos 2 argumentos"

desugar (Leq exprs) = case desugarBinary LeqV exprs of
    Just result -> result
    Nothing -> error "Leq requiere al menos 2 argumentos"

desugar (Geq exprs) = case desugarBinary GeqV exprs of
    Just result -> result
    Nothing -> error "Geq requiere al menos 2 argumentos"

desugar (Neq exprs) = case desugarBinary NeqV exprs of
    Just result -> result
    Nothing -> error "Neq requiere al menos 2 argumentos"

-- ==================
-- lógicos
-- ==================
desugar (Not expr) = NotV (desugar expr)

desugar (If cond thenExpr elseExpr) = IfV (desugar cond) (desugar thenExpr) (desugar elseExpr)

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

-- Núcleo de listas
desugar (Head expr) = HeadV (desugar expr)
desugar (Tail expr) = TailV (desugar expr)

-- ==================
-- funciones
-- ==================
desugar (Let bindings body) = desugarLet bindings body
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
    -- FALTA AGREGAR EL LET ESTRELLA PERO NO SE COMO IMPLEMENTARLO SI COMO AZUCAR SINTACTICA O COMO UN VALUE
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========
-- ========== ========== ========== ========== ========== ========== ========== ========== ========== ========== ==========


-- Función auxiliar para desazucarar let
-- vamos leyendo e izquierda a derecha y creando una app de funcion por cada let
desugarLet :: [(String, ASA)] -> ASA -> ASAValues
desugarLet [] body = desugar body
desugarLet [(var, expr)] body = 
    -- (let ((x e)) body) -> ((lambda (x) body) e)
    AppV (FunV var (desugar body)) (desugar expr)
desugarLet ((var, expr):rest) body = 
    -- Desazucarar recursivamente
    AppV (FunV var (desugarLet rest body)) (desugar expr)
