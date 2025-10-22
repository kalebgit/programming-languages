module SmallStep where

import Desugar
type Env = [(String, ASAValues)]
smallStep :: ASAValues -> Env -> (ASAValues, Env)

--como NumV se considera constructor debe ir entre parentesis
smallStep (NumV n) env = (NumV n, env)
smallStep (BooleanV b) env = (BooleanV b, env)

      -- ==================
    -- aritmeticos
    -- ==================
smallStep (AddV (NumV n) (NumV m)) env = (NumV (n + m), env)
smallStep (AddV (NumV n) d) env = 
    case smallStep d env of
        (d', env') -> smallStep (AddV (NumV n) d') env -- no se modifica el ambiente 
        _ -> error "no se resolvio la expresion"
smallStep (AddV i d) env = 
    case smallStep i env of
        (i', env') -> smallStep (AddV i' d) env -- no se modifica el ambiente 
        _ -> error "no se resolvio la expresion"


isValueV :: ASAValues -> Bool
isValueV (NumV _) = True
isValueV (BooleanV _) = True
-- isValueV (ClosureV _ _ _) = True
isValueV _ = False