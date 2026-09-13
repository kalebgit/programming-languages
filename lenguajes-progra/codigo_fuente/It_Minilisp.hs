-- anadir esta importacion:
import System.Console.Haskeline
import Control.Monad.IO.Class (liftIO)
import System.Environment (getArgs)

import Lex
import Desugar
import Grammars
import SmallStep

saca :: ASAValues -> String
saca (NumV n) = show n
saca (BooleanV b)
  | b == True = "#t"
  | otherwise = "#f"
saca (ClosureV p c e) = "#<procedure>"
saca NilV = "[]"
saca (ConsV x xs) = "[" ++ daElem x xs ++ "]"

daElem :: ASAValues -> ASAValues -> String
daElem x NilV = saca x -- el caso base es cuando llegamos a nilv
daElem c (ConsV x xs) = saca c ++ "," ++ daElem x xs -- caso recursivo, obtenemos la cabeza y buscamos en la cola

-- la funcion repl ahora debe ejecutarse dentro del 'inputt io'
-- para manejar el estado de la linea de entrada (historial, navegacion).
repl :: InputT IO () -- tipo de retorno modificado
repl =
  -- 'getinputline' reemplaza a 'getline' y maneja el prompt automaticamente.
  do
    mStr <- getInputLine "> "
    case mStr of
      -- el usuario puede escribir "null" (enter sin texto)
      Nothing -> repl
      -- el usuario escribio un comando o expresion
      Just str ->
        if str == "(exit)"
          then liftIO $ putStrLn "Bye." -- 'liftio' eleva io actions a inputt io
          else do
            -- la ejecucion del interprete (interp...) es una accion io,
            -- por lo que tambien necesita 'liftio'.
            -- nota: si 'interp' falla (e.g., error de parsing),
            -- deberias usar 'catch' o 'handle' para evitar que el repl se cierre.
            liftIO $ putStrLn $ saca (interp (desugar (parser (lexer str))) [])
            repl

-- la funcion principal 'run' ahora inicializa el inputt con 'runinputt'.
run :: IO ()
run =
  do
    putStrLn "Mini-Lisp_alcance_estatico Bienvenidos."
    -- runinputt toma un settings y la accion a ejecutar.
    -- aqui usamos 'defaultsettings' para la configuracion basica.
    runInputT defaultSettings repl

-- funcion para ejecutar un archivo .kal
runFile :: FilePath -> IO ()
runFile filename = do
  contenido <- readFile filename
  putStrLn $ saca (interp (desugar (parser (lexer contenido))) [])

-- la '?' al final de 'repl?' en tu codigo original
-- se ignora ya que es un comentario o un error de sintaxis.

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> run  -- sin argumentos: modo repl
    (filename:_) -> runFile filename  -- con argumentos: ejecutar archivo
