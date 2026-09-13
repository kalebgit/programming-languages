{
module Grammar where
import Lex (Token(..), lexer)
import Expr
}

%name parser
%tokentype { Token }
%error { parseError }

%token
    int  { TokenNum $$ }
    '+'  { TokenSum }
    '-'  { TokenSub }
    '*'  { TokenMult }
    '/'  { TokenDiv }
    '('  { TokenPA }
    ')'  { TokenPC }

%%

-- Gramatica para expresiones aritmeticas
Expresion : int                         { NumV $1 }
          | '(' '+' Expresion Expresion ')'  { AddV $3 $4 }
          | '(' '-' Expresion Expresion ')'  { SubV $3 $4 }
          | '(' '*' Expresion Expresion ')'  { MultV $3 $4 }
          | '(' '/' Expresion Expresion ')'  { DivV $3 $4 }

{
parseError :: [Token] -> a
parseError tokens = error $ "Parse error en tokens: " ++ show tokens

-- Funcion principal que toma un string y retorna una expresion
parseExpr :: String -> ASAValues
parseExpr = parser . lexer
}
