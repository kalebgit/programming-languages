module SmallStep where

import Desugar
type Env = [(String, ASAValues)]
smallStep :: ASAValues -> Env -> (ASAValues, Env)

-- Buscamos la variable usando la funcion axuliar varLookup
smallStep (IdV var) env = (varLookup var env, env)

--como NumV se considera constructor debe ir entre parentesis
smallStep (NumV n) env = (NumV n, env)
smallStep (BooleanV b) env = (BooleanV b, env)

--cosas de listas
smallStep NilV env = (NilV, env)


    -- ==================
    -- aritmeticos
    -- ==================

-- ============================= SUMA =====================================================================================
smallStep (AddV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n + m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (AddV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (AddV i' d, env')
-- =========================================================================================================================


-- ============================= RESTA =====================================================================================

-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
    -- TODO: resta con un argumetno
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
    
smallStep (SubV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n - m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (SubV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (SubV i' d, env')
-- =========================================================================================================================


-- ============================= MULTIIPLICACION =====================================================================================
smallStep (MultV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) -> (NumV (n * m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (MultV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (MultV i' d, env')
-- =========================================================================================================================

-- ============================= DIVISION =====================================================================================
smallStep (DivV expr1 expr2) env = case (expr1, expr2) of
    (NumV _, NumV 0) -> error "Division por cero no se puede hacer"
    
    (NumV n, NumV m) -> (NumV (n `div` m), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (DivV (NumV n) d', env')

    (i, d) -> case smallStep i env of
        (i', env') -> (DivV i' d, env')
-- =========================================================================================================================

-- ============================= EXPONENTE =====================================================================================
smallStep (ExpV expr1 expr2) env = case (expr1, expr2) of
    (NumV n, NumV m) ->  (NumV (n^m), env) -- Ojo, con el ^ solo consideramos lo numeros enteros positivos

    (NumV n, d) -> case smallStep d env of
       (d', env') -> (ExpV (NumV n) d', env')

    (i, d) -> case smallStep i env of
       (i', env') -> (ExpV i' d, env')
-- =========================================================================================================================

-- ============================= RAIZ =====================================================================================
smallStep (SqrV expr1) env = case  expr1 of
    NumV n | n < 0 -> error ("No se puede obtener la raiz del numero " ++ show n) 
           |otherwise -> (NumV (floor (sqrt (fromIntegral n))), env) 

    n -> case smallStep n env of
       (n', env') -> (SqrV n', env')




      -- ==================
    -- comparadores 
    -- ==================

-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
    -- TODO: Se deberian concatenar para variadicos con ANDS no? en el desugar digo
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 

-- ============================= IGUAL =====================================================================================
smallStep (EqV expr1 expr2) env = case (expr1, expr2) of
    (NilV, NilV) -> (BooleanV True, env)
    (p, NilV) -> case smallStep p env of
       (p', env') -> case isValue p' of
         True -> case p' of
           NilV -> (BooleanV True, env)
           otro ->(BooleanV False, env)
         False -> (EqV p' NilV, env')
    
    (NumV n1, NumV n2) -> (BooleanV (n1 == n2), env)
    
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (EqV (NumV n) d', env')
    
    (i, d) -> case smallStep i env of
        (i', env') -> (EqV i' d, env')
-- =========================================================================================================================


-- ============================= MENOR QUE =====================================================================================
smallStep (LtV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 < n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (LtV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (LtV i' d, env')
-- =========================================================================================================================

-- ============================= MAYOR QUE =====================================================================================
smallStep (GtV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 > n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (GtV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (GtV i' d, env')
-- =========================================================================================================================

-- ============================= MENOR O IGUAL QUE =====================================================================================
smallStep (LeqV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 <= n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (LeqV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (LeqV i' d, env')
-- =========================================================================================================================

-- ============================= MAYOR O IGUAL QUE =====================================================================================
smallStep (GeqV expr1 expr2) env = case (expr1, expr2) of
    (NumV n1, NumV n2) -> (BooleanV (n1 >= n2), env)
    (NumV n, d) -> case smallStep d env of
        (d', env') -> (GeqV (NumV n) d', env')
    (i, d) -> case smallStep i env of
        (i', env') -> (GeqV i' d, env')
-- =========================================================================================================================

-- ============================= DIFERENTE =====================================================================================
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
-- ============================= AND =====================================================================================
smallStep (AndV expr1 expr2) env = case (expr1, expr2) of
    (BooleanV b1, BooleanV b2) -> (BooleanV (b1 && b2), env)

    (BooleanV b1, d) -> case smallStep d env of
        (d', env') -> (AndV (BooleanV b1) d', env')

    (i, d) -> case smallStep i env of
        (i', env') -> (AndV i' d, env')
-- =========================================================================================================================


-- ============================= NOT =====================================================================================
smallStep (NotV expr) env = case expr of
    BooleanV b -> (BooleanV (not b), env)
    _ -> case smallStep expr env of
        (expr', env') -> (NotV expr', env')
-- =========================================================================================================================


-- ============================= IF =====================================================================================
smallStep (IfV cond thenExpr elseExpr) env = case cond of
    BooleanV True -> (thenExpr, env)
    
    BooleanV False -> (elseExpr, env)
    
    _ -> case smallStep cond env of
        (cond', env') -> (IfV cond' thenExpr elseExpr, env')

-- =========================================================================================================================







-- ==================
-- comparadores
-- ==================
-- ============================= PAR =====================================================================================
smallStep (PairV first second) env = case (isValue first, isValue second) of
    (True, True) -> (PairV first second, env)
    
    (True, False) -> case smallStep second env of
        (second', env') -> (PairV first second', env')
    
    (False, _) -> case smallStep first env of
        (first', env') -> (PairV first' second, env')
-- =========================================================================================================================



-- ============================= FIRST =====================================================================================
smallStep (FstV pair) env = case pair of
    PairV v1 v2 -> case (isValue v1, isValue v2) of
        (True, True) -> (v1, env)
        _ -> case smallStep pair env of
            (pair', env') -> (FstV pair', env')
    
    _ -> case smallStep pair env of
        (pair', env') -> (FstV pair', env')
-- =========================================================================================================================


-- ============================= SECOND =====================================================================================
smallStep (SndV pair) env = case pair of
    PairV v1 v2 -> case (isValue v1, isValue v2) of
        (True, True) -> (v2, env)
        _ -> case smallStep pair env of
            (pair', env') -> (SndV pair', env')
    
    _ -> case smallStep pair env of
        (pair', env') -> (SndV pair', env')
-- =========================================================================================================================





-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
    -- VOLVER A REPASAR TODAS LAS FUNCIONES DE LISTAS Y EVALUACIONES
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 
-- ========= ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======== ======= 

    -- ==================
    -- listas
    -- ==================

-- ============================= CONS =====================================================================================
    -- NOTA IMPORTANTE: en una lista con cons vamos reduciendo los valores de izquierda a derecha
-- Cons evalúa solo el primer elemento si no es valor
-- NO reduce recursivamente, solo un paso a la vez
smallStep (ConsV expr1 expr2) env = case expr2 of
    -- Verificar que expr2 sea NilV o ConsV (estructura de lista válida)
    NilV -> case isValue expr1 of
        -- expr1 ya es valor, la lista está completa
        True -> (ConsV expr1 NilV, env)
        -- expr1 necesita evaluación, dar UN PASO
        False -> case smallStep expr1 env of
            (expr1', env') -> (ConsV expr1' NilV, env')
    
    --si la expr2 no es un Nil entonces primero debemos evaluar el lado izquierdo para despues pasar con expr2
    ConsV _ _ -> case isValue expr1 of
        -- expr1 ya es valor, mantener como está (no tocar expr2)
        True -> case smallStep expr2 env of
            (expr2', env') -> (ConsV expr1 expr2', env') --NO SE SI DEBEMOS OMITIR EL AMBIENTE CAMBIADO
        -- expr1 necesita evaluación, dar UN PASO
        False -> case smallStep expr1 env of
            (expr1', env') -> (ConsV expr1' expr2, env')
            
    p -> case smallStep p env of
          (expr', env') -> (ConsV expr1 expr', env')

-- ============================= NILV =====================================================================================

    
    --creo que ya no es necesario esta parte XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    -- -- expr2 no es NilV ni ConsV, debe evaluarse para verificar estructura
    -- _ -> case smallStep expr2 env of
    --     (expr2', env') -> (ConsV expr1 expr2', env')
    --- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- =========================================================================================================================



-- ============================= HEAD =====================================================================================
smallStep (HeadV expr) env = case expr of
    NilV -> error "head de lista vacía"
    
    -- Si es ConsV con primer elemento valor, extraer
    ConsV v1 rest -> case isValue v1 of
        True -> case rest of
            NilV -> (v1, env)
            ConsV _ _ -> (v1, env)
            _ -> error "Lista mal formada: debe ser nil o cons"
        -- Primer elemento no es valor, evaluar la expresión
        False -> case smallStep expr env of
            (expr', env') -> (HeadV expr', env')
    
    -- Evaluar la expresión primero
    _ -> case smallStep expr env of
        (expr', env') -> (HeadV expr', env')
-- =========================================================================================================================



-- ============================= TAIL =====================================================================================
smallStep (TailV expr) env = case expr of
    NilV -> error "tail de lista vacía"
    
    -- Si es ConsV con primer elemento valor, extraer resto
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
            _ -> error "Lista mal formada: debe ser nil o cons"
        -- Primer elemento no es valor, evaluar la expresión
        False -> case smallStep expr env of
            (expr', env') -> (TailV expr', env')
    
    -- Evaluar la expresión primero
    _ -> case smallStep expr env of
        (expr', env') -> (TailV expr', env')



-- ============================================================================
-- FunV, AppV (de esto se deriva los casos del let)
-- ============================================================================


smallStep (FunV p c) env = (ClosureV p c env , env) -- Creamos una cerradura para cada funcion

-- Reglas para la Aplicación (AppV)
smallStep (AppV f pr) env = case f of
    
    -- REGLA 2: Si la FUNCIÓN NO es un VALOR, (hay que reducirla).
    _ | not (isValue f) -> 
        case smallStep f env of
            (f', env') -> (AppV f' pr, env')

    -- f es un VALOR a partir de aquí. Debe ser una Clausura.
    (ClosureV p c e) -> case pr of
        
        -- REGLA 3: Si el ARGUMENTO NO es un VALOR, redúcelo (f ya es valor).
        _ | not (isValue pr) -> 
            case smallStep pr env of
                (pr', env') -> (AppV (ClosureV p c e) pr', env')
                
        -- REGLA 4: Beta-Reducción (f y pr son valores)
        pr_val | isValue pr_val -> (resultValue, env)
            where localEnv = (p, pr_val) : e
            -- Se usa evalBody para evaluar COMPLETAMENTE el cuerpo
            -- y obtener solo el valor, descartando el ambiente local.
                  resultValue = evalBody c localEnv
        
    -- REGLA 5: Error de Tipo (Si f es un valor, pero no una ClosureV)
    -- Esto maneja casos como (5 3).
    _ -> error "Error de tipo: Se intentó aplicar un valor que no es una función (ClosureV)."

-- evalBody :: ASAValues -> Env -> ASAValues
-- Esta función se encarga de evaluar el cuerpo
evalBody :: ASAValues -> Env -> ASAValues
evalBody e env
    | isValue e = e
    | otherwise = evalBody e' env'  -- Llama a la recursión usando las variables de 'where'
    where
        -- Definiciones locales usando el bloque 'where'
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
    NilV -> True
    -- FunV _ _ -> True
    ClosureV _ _ _ -> True
    PairV v1 v2 -> isValue v1 && isValue v2
    -- Una lista es valor solo si TODOS sus elementos son valores
    ConsV v1 rest -> isValue v1 && isValue rest
    _ -> False

interp :: ASAValues -> Env -> ASAValues
interp e env
    | isValue e = e  -- Caso base: Si ya es un valor, devuelve el valor
    | otherwise =
        -- Usa case para obtener el resultado de smallStep y ligarlo a e' y env'
        case smallStep e env of
            (e', env') -> interp e' env'
            
            -- La función de traza requiere que ASAValues y Env sean instancias de Show.


