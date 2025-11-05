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
    '++' { TokenConc}
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
    'and' { TokenAnd }
    'not' { TokenNot }
    'if' {TokenIf }
    '(' { TokenPA }
    ')' { TokenPC }


    -- ==================
    -- funciones
    -- ==================
    --cosas con let
    'let' { TokenLet }
    'let*' {TokenLetStar}
    'letrec' {TokenLetRec}
   --cosas con cond
    "cond" { TokenCond }
    "else" {TokenElse}
    -- lambda
    "lambda" {TokenLambda}

    -- ==================
    -- listas
    -- ==================
    ',' {TokenComma}
    '[' {TokenCA}
    ']' {TokenCC}
    'head' {TokenHead}
    'tail' {TokenTail}

    var  {TokenVar $$} -- obtenemos el nombre de la variable (i.e. que ya es String?)


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
    | '(' 'expt' ASA ASAExprs ')' {Expt $3 $4}
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
    | '(' 'and' ASAExprs ')' {And $3}
    | '(' 'not' ASA ')' {Not $3}
    | '(' 'if' ASA ASA ASA')' {If $3 $4 $5}
    -- ==================
    -- funciones
    -- ==================
    --queremos que acepte varias asignaciones
    | '(' 'let' '(' ASABindings ')' ASA ')' { Let $4 $6} 
    | '(' 'let*' '(' ASABindings ')' ASA ')' { LetStar $4 $6}
    | '(' 'letrec' '(' ASABindings ')' ASA ')' { LetRec $4 $6}
    -- agregamos Cond
    --| '(' "cond"  ASACond '[' "else" ASA ']' ')' { CondElse $3 $6}
    | '(' "cond"  ASACond  "else" ASA  ')' { CondElse $3 $5}    
    -- agregamos lambda, app.
    | '(' "lambda" '(' ListVar ')'  ASA ')' { Lambda $4 $6 }			  
    | '(' ASA  ASAExprs ')' { App $2 $3} 

    -- ==================
    -- listas
    -- estas ya son propias del lenguaje 
    -- ==================
    | '(' '++' ASA ASA ')' { Conc $3 $4 }
    | '(' 'head' ASA ')' { Head $3 }
    | '(' 'tail' ASA ')' { Tail $3 }

    | '[' ']' {List []} --el argumetno es la lista vacia propia de haskell primero va este caso
    | '[' Listitems ']' {List $2}


Listitems : ASA { [$1] }
        | ASA ',' Listitems { $1 : $3}


    --listas de ASAS para variadicos
--se necesita el caso base para empezar a concatenar y poder tener listas
ASAExprs : {- empty -} {[]} 
    | ASA ASAExprs {$1 : $2}

    --tupla para las asignaciones
ASABindings : {- empty -} { [] }
    | '(' var ASA ')' ASABindings { ($2 , $3) : $5} -- asi nos deshacemos de Var en la parte de definiciones y no hay confusiones pues son solo strings
    |  var ASA {[($1, $2)]}

    --tupla para CondElse
ASAC : '[' ASA ASA ']' { ($2, $3) }
    
ASACond : ASAC { [$1] }
    |  ASAC ASACond { $1 : $2}

    -- argumento para lambda
ListVar: var ListVar  { $1 : $2}
    | var       {[$1]}









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
    | Expt ASA [ASA]
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
    | And [ASA] -- es el and de todos los de la lista por ejemplo AND [True, False, True] ->  False
    | Not ASA
    | If ASA ASA ASA



    --cosas con let
    | Let [(String, ASA)] ASA 
    | LetStar [(String, ASA)] ASA
    | LetRec [(String, ASA)] ASA  
    | Var String
    -- cond
    | CondElse [(ASA, ASA)] ASA  
    -- app y lambda
    | Lambda [String] ASA   
    | App ASA [ASA]   

    -- ==================
    -- listas
    -- ==================
    | Conc ASA ASA
    | List [ASA]
    | Tail ASA
    | Head ASA
    deriving (Show)
}
