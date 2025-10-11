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
    -- ==================
    -- aritmeticos
    -- ==================
    '+' { TokenSum }
    '-' { TokenSub }
    '*' { TokenMult}
    '/' { TokenDiv}
    'add1' { TokenAdd1}
    'sub1' { TokenSub1}
    'sqrt' { TokenSqrt}
    'expt' { TokenExpt}

    -- ==================
    -- pares ordenados
    -- ==================
    'fst' {TokenFst}
    'snd' {TokenSnd}

    -- ==================
    -- comparadores
    -- ==================
    '='  { TokenEq }
    '<'  { TokenLt }
    '>'  { TokenGt }
    '<=' { TokenLeq }
    '>=' { TokenGeq }
    '!=' { TokenNeq }
    -- ==================
    -- logicos
    -- ==================
    "not" { TokenNot }
    '(' { TokenPA }
    ')' { TokenPC }


    -- ==================
    -- funciones
    -- ==================
    --cosas con let
    "let" { TokenLet }
    var  {TokenVar $$} -- obtenemos el nombre de la variable

    -- ==================
    -- otros
    -- ==================
    ',' {TokenComma}




%%

ASA : int {Num $1} -- estas ya son 
    | bool {Boolean $1} -- ya es la sintaxis del lenguaje anfitrion
    | var {Var $1}
    -- ==================
    -- aritmeticos
    -- ==================
    | '(' '+' ASAExprs ')' {Add $3}
    | '(' '-' ASAExprs ')' {Sub $3}
    | '(' '*' ASAExprs ')' {Mult $3}
    | '(' '/' ASAExprs ')' {Div $3}
    | '(' 'add1' ASAExprs ')' {Add1 $3}
    | '(' 'sub1' ASAExprs ')' {Sub1 $3}
    | '(' 'sqrt' ASAExprs ')' {Sqrt $3}
    | '(' 'expt' ASAExprs ')' {Expt $3}
    -- ==================
    -- pares ordenados 
    -- ==================
    | '(' ASA ',' ASA ')' {Pair $2 $4}
    | '(' 'fst' ASA ')' {Fst $3}
    | '(' 'snd' ASA ')' {Snd $3}

    -- ==================
    -- comparadores 
    -- ==================
    | '(' '=' ASAExprs ')' {Eq $3}
    | '(' '<' ASAExprs ')' {Lt $3}
    | '(' '>' ASAExprs ')' {Gt $3}
    | '(' '<=' ASAExprs ')' {Leq $3}
    | '(' '>=' ASAExprs ')' {Geq $3}
    | '(' '!=' ASAExprs ')' {Neq $3}
    -- ==================
    -- logicos
    -- ==================
    | '(' "not" ASA ')' {Not $3}
    -- ==================
    -- funciones
    -- ==================
    | '(' "let" '(' ASA ASA ')' ASA ')' { Let $4 $5 $7} -- no distingue si es ligada o la def




    --listas 
ASAExprs : {- empty -} {[]} --se necesita el caso base para empezar a concatenar y poder tener listas
    | ASA ASAExprs {$1 : $2}







{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data ASA 
    = Num Int
    | Boolean Bool
    -- ==================
    -- aritmeticos
    -- ==================
    | Add [ASA]
    | Sub [ASA]
    | Mult [ASA]
    | Div [ASA]
    | Add1 [ASA]
    | Sub1 [ASA]
    | Sqrt [ASA]
    | Expt [ASA]
    -- ==================
    -- pares ordenados
    -- ==================
    | Pair ASA ASA
    | Fst ASA
    | Snd ASA
    -- ==================
    -- comparadores 
    --  ponemos que significa cada uno para que no haya confusiones
    -- ==================
    | Eq [ASA]   -- =
    | Lt [ASA]   -- 
    | Gt [ASA]   -- >
    | Leq [ASA]  -- <=
    | Geq [ASA]  -- >=
    | Neq [ASA]  -- !=

    -- ==================
    -- logicos
    -- ==================
    | Not ASA
    --listas
    | List [ASA]



    --cosas con let
    | Let ASA ASA ASA
    | Var String
    deriving (Show)
}