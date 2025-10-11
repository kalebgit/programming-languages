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
    var  {TokenVar $$} -- obtenemos el nombre de la variable (i.e. que ya es String?)

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
    --queremos que acepte varias asignaciones
    | '(' "let" '(' ASABindings ')' ASA ')' { Let $4 $6} -- no distingue si es ligada o la def




    --listas 
ASAExprs : {- empty -} {[]} --se necesita el caso base para empezar a concatenar y poder tener listas
    | ASA ASAExprs {$1 : $2}

    --tupla para las asignaciones
ASABindings : {- empty -} { [] }
    | '(' var ASA ')' ASABindings { ($2 , $3) : $5} -- asi nos deshacemos de Var en la parte de definiciones y no hay confusiones pues son puros strings
    |  var ASA {[($1, $2)]}






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
    | Let [(String, ASA)] ASA 
    | Var String
    deriving (Show)
}