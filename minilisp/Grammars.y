{
module Grammars where
import Lex (Token(..), lexer)
}

%name parser
%tokentype { Token } -- por eso lo importamos del .hs
%error { parseError } -- un tipo personalizado

%token 
    --los transformamos 
    int { TokenNum $$ }
    bool { TokenBool $$ }
    '+' { TokenSum }
    '-' { TokenSub }
    "not" { TokenNot }
    '(' { TokenPA }
    ')' { TokenPC }


    --cosas con let
    "let" { TokenLet }
    var  {TokenVar $$} -- obtenemos el nombre de la variable



%%

ASA : int {Num $1} -- estas ya son 
    | bool {Boolean $1} -- ya es la sintaxis del lenguaje anfitrion
    | var {Var $1}
    | '(' '+' ASA ASA ')' {Add $3 $4}
    | '(' '-' ASA ASA ')' {Sub $3 $4}
    | '(' "not" ASA ')' {Not $3}



    --cosas con let: no se si esta bien que reciba asas 
    -- no se como ponerlo explicito que solo puedan ser vars
    | '(' "let" '(' ASA ASA ')' ASA ')' { Let $4 $5 $7}
    -- TODO: hay un error pues en el cuerpo
    -- si hay identificadores no se cambia a Id(a) 
    -- o algo para distinguir si es var ligada o no, pero eso se sabe con la posicion no?




{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data ASA 
    = Num Int
    | Boolean Bool
    | Add ASA ASA
    | Sub ASA ASA
    | Not ASA



    --cosas con let
    | Let ASA ASA ASA
    | Var String
    deriving (Show)
}