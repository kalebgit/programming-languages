{
module Lex (Token(..), lexer) where
import Data.Char (isSpace)
}

%wrapper "basic"

-- Espacios en blanco (unicode)
$white = [\x20\x09\x0A\x0D\x0C\x0B]
$digit = 0-9

tokens :-
    $white+              ;
    \(                   {\_ -> TokenPA}
    \)                   {\_ -> TokenPC}

    -- Numeros (soporta negativos)
    \-?$digit+           {\s -> TokenNum (read s)}

    -- Operadores aritmeticos
    \+                   {\_ -> TokenSum}
    \-                   {\_ -> TokenSub}
    \*                   {\_ -> TokenMult}
    \/                   {\_ -> TokenDiv}

    -- Error para caracteres no reconocidos
    .                    {\s -> error ("Lexical error: caracter no reconocido = "
                                    ++ show s
                                    ++ " | codepoints = "
                                    ++ show (map fromEnum s))}

-- Definicion de tokens
{
data Token
    = TokenNum Int
    | TokenSum
    | TokenSub
    | TokenMult
    | TokenDiv
    | TokenPA
    | TokenPC
    deriving (Show, Eq)

normalizeSpaces :: String -> String
normalizeSpaces = map (\c -> if isSpace c then '\x20' else c)

-- Funcion principal del lexer
-- Usa alexScanTokens generada por Alex
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
}
