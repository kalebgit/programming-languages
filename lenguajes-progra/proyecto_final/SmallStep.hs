module SmallStep where

import Desugar
type Env = [(String, ASAValues)]
smallStep :: ASAValues -> Env -> (ASAValues, Env)

-- buscamos la variable usando la funcion axuliar varlookup
smallStep (IdV var) env = (varLookup var env, env)

--como numv se considera constructor debe ir entre parentesis
smallStep (NumV n) env = (NumV n, env)
smallStep (BooleanV b) env = (BooleanV b, env)
smallStep (StringV s) env = (StringV s, env)

--cosas de listas
smallStep NilV env = (NilV, env)


    -- ==================
    -- aritmeticos
    -- ==================

-- ============================= suma =====================================================================================
smallStep (AddV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n + m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (AddV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (AddV i' d, env')
-- =========================================================================================================================


-- ============================= resta =====================================================================================

    
smallStep (SubV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n - m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (SubV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (SubV i' d, env')
-- =========================================================================================================================


-- ============================= multiiplicacion =====================================================================================
smallStep (MultV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n * m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (MultV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (MultV i' d, env')
-- =========================================================================================================================

-- ============================= division =====================================================================================
smallStep (DivV expr1 expr2) env = case (expr1, expr2) of
    (NumV _, NumV 0) -> error "division por cero no se puede hacer"
    
    (NumV n, NumV m) -> (NumV (n `div` m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (DivV (NumV n) d', env')

    (i, d) -> case smallStep i env of
        (i', env') -> (DivV i' d, env')
-- =========================================================================================================================

-- ============================= exponente =====================================================================================
smallStep (ExpV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) ->  (NumV (n^m), env) -- ojo, con el ^ solo consideramos lo numeros enteros positivos

    (NumV n, d) -> case smallStep d env of
       (d', env') -> (ExpV (NumV n) d', env')

    (i, d) -> case smallStep i env of
       (i', env') -> (ExpV i' d, env')
-- =========================================================================================================================

-- ============================= raiz =====================================================================================
smallStep (SqrV expr1) env = case  expr1 of
    NumV n | n < 0 -> error ("no se puede obtener la raiz del numero " ++ show n) 
           |otherwise -> (NumV (floor (sqrt (fromIntegral n))), env) 

    n -> case smallStep n env of
       (n', env') -> (SqrV n', env')




      -- ==================
    -- comparadores 
    -- ==================


-- ============================= igual =====================================================================================
smallStep (EqV expr1 expr2) env = case (expr1, expr2) of
    (NilV, NilV) -> (BooleanV True, env)
    (p, NilV) -> case smallStep p env of
       (p', env') -> case isValue p' of
         True -> case p' of
           NilV -> (BooleanV True, env)
           otro ->(BooleanV False, env)
         False -> (EqV p' NilV, env')

    (NumV n1, NumV n2) -> (BooleanV (n1 == n2), env)

    (StringV s1, StringV s2) -> (BooleanV (s1 == s2), env)

    (StringV s, d) -> case smallStep d env of
        (d', env') -> (EqV (StringV s) d', env')

    (NumV n, d) -> case smallStep d env of
        (d', env') -> (EqV (NumV n) d', env')

    (i, d) -> case smallStep i env of
        (i', env') -> (EqV i' d, env')
-- =========================================================================================================================


-- ============================= menor que =====================================================================================
smallStep (LtV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 < n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (LtV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (LtV i' d, env')
-- =========================================================================================================================

-- ============================= mayor que =====================================================================================
smallStep (GtV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 > n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (GtV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (GtV i' d, env')
-- =========================================================================================================================

-- ============================= menor o igual que =====================================================================================
smallStep (LeqV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 <= n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (LeqV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (LeqV i' d, env')
-- =========================================================================================================================

-- ============================= mayor o igual que =====================================================================================
smallStep (GeqV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 >= n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (GeqV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (GeqV i' d, env')
-- =========================================================================================================================

-- ============================= diferente =====================================================================================
smallStep (NeqV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 /= n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (NeqV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (NeqV i' d, env')
-- =========================================================================================================================




    -- ==================
    -- logicos
    -- ==================
-- ============================= and =====================================================================================
smallStep (AndV expr1 expr2) env = case (expr1, expr2) of
    (BooleanV b1, BooleanV b2) -> (BooleanV (b1 && b2), env)

    (BooleanV b1, d) -> case smallStep d env of
        (d', env') -> (AndV (BooleanV b1) d', env')

    (i, d) -> case smallStep i env of
        (i', env') -> (AndV i' d, env')
-- =========================================================================================================================


-- ============================= not =====================================================================================
smallStep (NotV expr) env = case expr of
    BooleanV b -> (BooleanV (not b), env)
    _ -> case smallStep expr env of
        (expr', env') -> (NotV expr', env')
-- =========================================================================================================================


-- ============================= if =====================================================================================
smallStep (IfV cond thenExpr elseExpr) env = case cond of
    BooleanV True -> (thenExpr, env)
    
    BooleanV False -> (elseExpr, env)
    
    _ -> case smallStep cond env of
        (cond', env') -> (IfV cond' thenExpr elseExpr, env')

-- =========================================================================================================================







-- ==================
-- comparadores
-- ==================
-- ============================= par =====================================================================================
smallStep (PairV first second) env = case (isValue first, isValue second) of
    (True, True) -> (PairV first second, env)
    
    (True, False) -> case smallStep second env of
        (second', env') -> (PairV first second', env')
    
    (False, _) -> case smallStep first env of
        (first', env') -> (PairV first' second, env')
-- =========================================================================================================================



-- ============================= first =====================================================================================
smallStep (FstV pair) env = case pair of
    PairV v1 v2 -> case (isValue v1, isValue v2) of
        (True, True) -> (v1, env)
        _ -> case smallStep pair env of
            (pair', env') -> (FstV pair', env')
    
    _ -> case smallStep pair env of
        (pair', env') -> (FstV pair', env')
-- =========================================================================================================================


-- ============================= second =====================================================================================
smallStep (SndV pair) env = case pair of
    PairV v1 v2 -> case (isValue v1, isValue v2) of
        (True, True) -> (v2, env)
        _ -> case smallStep pair env of
            (pair', env') -> (SndV pair', env')
    
    _ -> case smallStep pair env of
        (pair', env') -> (SndV pair', env')
-- =========================================================================================================================






    -- ==================
    -- listas
    -- ==================

-- ============================= cons =====================================================================================
    -- nota importante: en una lista con cons vamos reduciendo los valores de izquierda a derecha
-- cons evalua solo el primer elemento si no es valor
-- no reduce recursivamente, solo un paso a la vez



smallStep (ConsV NilV rest) env = (rest, env)



smallStep (ConsV expr1 expr2) env = case expr2 of
    -- verificar que expr2 sea nilv o consv (estructura de lista valida)
    NilV -> case isValue expr1 of
        -- expr1 ya es valor, la lista esta completa
        True -> (ConsV expr1 NilV, env)
        -- expr1 necesita evaluacion, dar un paso
        False -> case smallStep expr1 env of
            (expr1', env') -> (ConsV expr1' NilV, env')

    --si la expr2 no es un nil entonces primero debemos evaluar el lado izquierdo para despues pasar con expr2
    ConsV _ _ -> case isValue expr1 of
        -- expr1 ya es valor, mantener como esta (no tocar expr2)
        True -> case smallStep expr2 env of
            (expr2', env') -> (ConsV expr1 expr2', env') --no se si debemos omitir el ambiente cambiado
        -- expr1 necesita evaluacion, dar un paso
        False -> case smallStep expr1 env of
            (expr1', env') -> (ConsV expr1' expr2, env')
            
    p -> case smallStep p env of
          (expr', env') -> (ConsV expr1 expr', env')

-- ============================= nilv =====================================================================================
-- este se representa ya en el flujo de ejecucion como la lista vacia [], por eso no se implementa.


-- ============================= head =====================================================================================
smallStep (HeadV expr) env = case expr of
    NilV -> error "head de lista vacia"

    -- si es consv con primer elemento valor, extraer
    ConsV v1 rest -> case isValue v1 of
        True -> case rest of
            NilV -> (v1, env)
            ConsV _ _ -> (v1, env)
            _ -> error "lista mal formada: debe ser nil o cons"
        -- primer elemento no es valor, evaluar la expresion
        False -> case smallStep expr env of
            (expr', env') -> (HeadV expr', env')

    -- evaluar la expresion primero
    _ -> case smallStep expr env of
        (expr', env') -> (HeadV expr', env')
-- =========================================================================================================================



-- ============================= tail =====================================================================================
smallStep (TailV expr) env = case expr of
    NilV -> error "tail de lista vacia"

    -- si es consv con primer elemento valor, extraer resto
    ConsV v1 rest -> case isValue v1 of
        True -> case rest of
            NilV -> (NilV, env)
            {-}
            ConsV v NilV -> case isValue v of
              True -> (ConsV v NilV, env)
              False -> case smallStep v env of
                (expr', env') -> (TailV expr', env')
-}
            ConsV _ _ -> (rest, env)
            _ -> error "lista mal formada: debe ser nil o cons"
        -- primer elemento no es valor, evaluar la expresion
        False -> case smallStep expr env of
            (expr', env') -> (TailV expr', env')

    -- evaluar la expresion primero
    _ -> case smallStep expr env of
        (expr', env') -> (TailV expr', env')



-- ============================================================================
-- funv, appv (de esto se deriva los casos del let)
-- ============================================================================


smallStep (FunV p c) env = (ClosureV p c env , env) -- creamos una cerradura para cada funcion


-- reglas para la aplicacion (appv)
smallStep (AppV f pr) env = case f of

    -- regla 2: si la funcion no es un valor, (hay que reducirla).
    _ | not (isValue f) ->
        case smallStep f env of
            (f', env') -> (AppV f' pr, env')

    -- f es un valor a partir de aqui. debe ser una clausura.
    (ClosureV p c e) -> case pr of

        -- regla 3: si el argumento no es un valor, reducelo (f ya es valor).
        _ | not (isValue pr) ->
            case smallStep pr env of
                (pr', env') -> (AppV (ClosureV p c e) pr', env')
        {-
        -- regla 4: beta-reduccion (f y pr son valores)
        pr_val | isValue pr_val -> (c, localEnv)           -- este opcion no maneja el caso de contagio de ambientes
            where localEnv = (p, pr_val) : e
        -}
        pr_val | isValue pr_val -> (resultValue, env)               -- este otra opcion maneja el caso de contagio del ambiente, pero a costa de
                                                                    -- al evaluar el cuerpo de golpe se come la variable y ya no la agrega al env.
            where localEnv = (p, pr_val) : e
            -- se usa evalbody para evaluar completamente el cuerpo
            -- y obtener solo el valor, descartando el ambiente local.
                  resultValue = evalBody c localEnv

    -- regla 5: error de tipo (si f es un valor, pero no una closurev)
    -- esto maneja casos como (5 3).
    _ -> error "error de tipo: se intento aplicar un valor que no es una funcion (closurev)." 


-- evalbody :: asavalues -> env -> asavalues
-- esta funcion se encarga de evaluar el cuerpo, !!! lo malo es que se evalua de golpe, violando la semantica natural de paso pequeno¡¡¡¡
evalBody :: ASAValues -> Env -> ASAValues
evalBody e env
    | isValue e = e
    | otherwise = evalBody e' env'  -- llama a la recursion usando las variables de 'where'
    where
        -- definiciones locales usando el bloque 'where'
        (e', env') = smallStep e env

varLookup :: String -> Env -> ASAValues
varLookup var [] = error ("variable " ++ var ++ " no encontrada") 
varLookup var ((var2, val):xs)
    | var == var2 = val
    | otherwise = varLookup var xs


isValue :: ASAValues -> Bool
isValue expr = case expr of
    NumV _ -> True
    BooleanV _ -> True
    StringV _ -> True
    NilV -> True
    -- FunV _ _ -> True
    ClosureV _ _ _ -> True
    PairV v1 v2 -> isValue v1 && isValue v2
    -- nueva regla: listas que comienzan con nilv no son valores (para reducirlas)
    ConsV NilV _ -> False
    -- regla original: una lista es valor solo si todos sus elementos son valores
    ConsV v1 rest -> isValue v1 && isValue rest
    _ -> False

interp :: ASAValues -> Env -> ASAValues
interp e env
    | isValue e = e  -- caso base: si ya es un valor, devuelve el valor
    | otherwise =
        -- usa case para obtener el resultado de smallstep y ligarlo a e' y env'
        case smallStep e env of
            (e', env') -> interp e' env'

            -- la funcion de traza requiere que asavalues y env sean instancias de show.


