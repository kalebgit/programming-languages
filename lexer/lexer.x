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
    \(                  {\_ -> TokenPA} -- donde \_ significa que no hay parametros
    \)                  {\_ -> TokenPC}
    \+                  {\_ -> TokenSum}
    \-                  {\_ -> TokenSub}
    not                  {\_ -> TokenNot}
    "#t"                  {\_ -> TokenBool True}
    "#f"                  {\_ -> TokenBool False}
    $digit+                  {\s -> TokenNum (read s) } --

    .                     { \s -> error ("Lexical error: caracter no reconocido = "
                                    ++ show s
                                    ++ " | codepoints = "
                                    ++ show (map fromEnum s)) }


-- nuestro codigo que define los tokens en haskell
{
data Token 
    = TokenNum Int
    | TokenBool Bool
    | TokenSum
    | TokenSub
    | TokenNot
    | TokenPA -- parentesis que abre
    | TokenPC -- parentesis que cierra
    deriving (Show)

normalizeSpaces :: String -> String
normalizeSpaces = map (\c -> if isSpace c then '\x20' else c)

-- usamos la funcion de Alex: alexScanTokens que es la que usa nuestros tokens
-- y cuando recibe un string recorre el string y va creando los tokens

-- Nota: esta funcion se obtiene gracias a %wrapper
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
}