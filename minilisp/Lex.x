{
module Lex (Token(..), lexer) where
import Data.Char (isSpace)
}

%wrapper "basic"

--recordando los espacios en unicode
----   \x20 = ' ' (space), \x09 = tab, \x0A = LF, \x0D = CR, \x0C = FF, \x0B = VT

$white = [\x20\x09\x0A\x0D\x0C\x0B]
$digit = 0-9

tokens :-
    $white+              ;
    \(                      {\_ -> TokenPA} -- donde \_ significa que no hay parametros
    \)                      {\_ -> TokenPC}
    \[                      {\_ -> TokenCA} --corchete que abre
    \]                      {\_ -> TokenCC} --corchete que cierra
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
    --tengo que agregar AND para el resultado de comparadores
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

    -- ==================
    -- nuestras primeras nociones de nucleo
    -- ==================
    nil                     {\_ -> TokenNil}
    cons                    {\_ -> TokenCons}

    --regex del var y num
    $digit+                 {\s -> TokenNum (read s) } --
    [a-zA-Z][a-zA-Z0-9]*    {\s -> TokenVar s}

    

    .                     { \s -> error ("Lexical error: caracter no reconocido = "
                                    ++ show s
                                    ++ " | codepoints = "
                                    ++ show (map fromEnum s)) }


-- nuestro codigo que define los tokens en haskell
{
data Token 
    = TokenNum Int
    | TokenBool Bool
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
    -- ==================
    -- listas 
    -- ==================
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

-- usamos la funcion de Alex: alexScanTokens que es la que usa nuestros tokens
-- y cuando recibe un string recorre el string y va creando los tokens

-- Nota: esta funcion se obtiene gracias a %wrapper
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
}
