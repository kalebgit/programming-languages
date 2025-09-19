{
    module Grammars where 
    import Lex (Token(..), lexer)
}

%name parser
%tokeytype { Token } -- por eso lo importamos del .hs
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
%%

ASA : int {Num $1} -- estas ya son 
    | bool {Boolean $1} -- ya es la sintaxis del lenguaje anfitrion
    | '(' '+' ASA ASA ')' {Add $3 $4}
    | '(' '-' ASA ASA ')' {Sub $3 $4}
    | '(' "not" ASA ')' {Not $3}

{

praseError :: [Token] -> a
parseError _ = error "Parse error"

data ASA 
    = Num Int
    | Boolean Bool
    | Add ASA ASA
    | Sub ASA ASA
    | Not ASA
    deriving (Show)
}