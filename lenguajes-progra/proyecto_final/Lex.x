{
module Lex (Token(..), lexer) where
import Data.Char (isSpace)
}

%wrapper "basic"

--recordando los espacios en unicode
----   \x20 = ' ' (space), \x09 = tab, \x0a = lf, \x0d = cr, \x0c = ff, \x0b = vt

$white = [\x20\x09\x0A\x0D\x0C\x0B]
$digit = 0-9

tokens :-
    $white+              ;
    \(                      {\_ -> TokenPA} -- donde \_ significa que no hay parametros
    \)                      {\_ -> TokenPC}
    \[                      {\_ -> TokenCA} --corchete que abre
    \]                      {\_ -> TokenCC} --corchete que cierra
    -- ==================
    -- regex de numeros
    -- ==================
    \-?$digit+             {\s -> TokenNum (read s) } -- soporta numeros negativos(por eso de define antes que el \-)
    "++"                   {\_ -> TokenConc} -- se usara para agregar un elemento a una lista      

    -- ==================
    -- aritmeticos
    -- ==================
    \+                      {\_ -> TokenSum}
    \-                      {\_ -> TokenSub}
    \*                      {\_ -> TokenMult}
    \/                      {\_ -> TokenDiv}
    add1                    {\_ -> TokenAdd1}
    sub1                    {\_ -> TokenSub1}
    sqrt                    {\_ -> TokenSqrt}
    expt                    {\_ -> TokenExpt}

    -- ==================
    -- listas
    -- ==================
    ","                     {\_ -> TokenComma}
    head                    {\_ -> TokenHead}
    tail                    {\_ -> TokenTail}

    -- ==================
    -- pares ordenados 
    -- ==================
    fst                    {\_ -> TokenFst}
    snd                    {\_ -> TokenSnd}

    -- ==================
    -- comparadores 
    -- ==================
    "!="                    {\_ -> TokenNeq}
    "<="                    {\_ -> TokenLeq}
    ">="                    {\_ -> TokenGeq}
    "="                     {\_ -> TokenEq}
    "<"                     {\_ -> TokenLt}
    ">"                     {\_ -> TokenGt}
    -- ==================
    -- logicos
    -- ==================
    --tengo que agregar and para el resultado de comparadores
    and                     {\_ -> TokenAnd}

    not                     {\_ -> TokenNot}
    -- lo poneos con comillas pues '#' es parte de la sintaxis geenral de un regex
    "#t"                    {\_ -> TokenBool True}
    "#f"                    {\_ -> TokenBool False}
    if                     {\_ -> TokenIf}

    -- ==================
    -- funciones
    -- ==================
    --agregamos los relacionados al let
    let                     {\_ -> TokenLet }
    let\*                   {\_ -> TokenLetStar }
    letrec                     {\_ -> TokenLetRec }    
    
    -- agregamos los demas 
    cond                     {\_ -> TokenCond }
    else                   {\_ -> TokenElse }
    -- agragamos lambda
    lambda                   {\_ -> TokenLambda }                
    -- ==================
    -- nuestras primeras nociones de nucleo
    -- ==================
    nil                     {\_ -> TokenNil}
    cons                    {\_ -> TokenCons}

    --regex del var
    [a-zA-Z][a-zA-Z0-9_]*    {\s -> TokenVar s}

    -- ==================
    -- strings
    -- ==================
    -- reconoce strings entre comillas dobles (sin soporte para escapes por simplicidad)
    \"[^\"]*\"              {\s -> TokenString (init (tail s))}



    .                     { \s -> error ("lexical error: caracter no reconocido = "
                                    ++ show s
                                    ++ " | codepoints = "
                                    ++ show (map fromEnum s)) }


-- nuestro codigo que define los tokens en haskell
{
data Token
    = TokenNum Int
    | TokenBool Bool
    | TokenString String
    -- ==================
    -- aritmeticos
    -- ==================
    | TokenSum
    | TokenSub
    | TokenMult
    | TokenDiv
    | TokenAdd1
    | TokenSub1
    | TokenSqrt
    | TokenExpt

    -- ==================
    -- pares ordenados
    -- ==================
    | TokenFst
    | TokenSnd

    -- ==================
    -- comparadores
    -- ==================
    | TokenEq   -- =
    | TokenLt   -- <
    | TokenGt   -- >
    | TokenLeq  -- <=
    | TokenGeq  -- >=
    | TokenNeq  -- !=

    -- ==================
    -- logicos
    -- ==================
    | TokenAnd
    | TokenNot          
    | TokenIf
    | TokenPA          
    | TokenPC         



    -- ==================
    -- funciones
    -- ==================
    -- relacionado con let
    | TokenLet
    | TokenLetStar
    | TokenLetRec
    -- relacionadas con cond
    | TokenCond
    | TokenElse
    -- lambda
    | TokenLambda
    
    -- ==================
    -- listas 
    -- ==================
    | TokenConc
    | TokenComma
    | TokenCA
    | TokenCC
    | TokenHead
    | TokenTail

    -- ==================
    -- nuestras primeras nociones de nucleo
    -- ==================
    | TokenCons
    | TokenNil
    | TokenVar String

    deriving (Show)

normalizeSpaces :: String -> String
normalizeSpaces = map (\c -> if isSpace c then '\x20' else c)

-- usamos la funcion de alex: alexscantokens que es la que usa nuestros tokens
-- y cuando recibe un string recorre el string y va creando los tokens

-- nota: esta funcion se obtiene gracias a %wrapper
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
}
