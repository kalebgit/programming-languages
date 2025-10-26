-- Añadir esta importación:
import System.Console.Haskeline
import Control.Monad.IO.Class (liftIO)

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

-- La función repl ahora debe ejecutarse dentro del 'InputT IO'
-- para manejar el estado de la línea de entrada (historial, navegación).
repl :: InputT IO () -- Tipo de retorno modificado
repl =
  -- 'getInputLine' reemplaza a 'getLine' y maneja el prompt automáticamente.
  do
    mStr <- getInputLine "> "
    case mStr of
      -- El usuario puede escribir "null" (Enter sin texto)
      Nothing -> repl
      -- El usuario escribió un comando o expresión
      Just str ->
        if str == "(exit)"
          then liftIO $ putStrLn "Bye." -- 'liftIO' eleva IO actions a InputT IO
          else do
            -- La ejecución del intérprete (interp...) es una acción IO,
            -- por lo que también necesita 'liftIO'.
            -- NOTA: Si 'interp' falla (e.g., error de parsing),
            -- deberías usar 'catch' o 'handle' para evitar que el REPL se cierre.
            liftIO $ putStrLn $ saca (interp (desugar (parser (lexer str))) [])
            repl

-- La función principal 'run' ahora inicializa el InputT con 'runInputT'.
run :: IO ()
run =
  do
    putStrLn "Mini-Lisp_alcance_estatico Bienvenidos."
    -- runInputT toma un Settings y la acción a ejecutar.
    -- Aquí usamos 'defaultSettings' para la configuración básica.
    runInputT defaultSettings repl

-- La '?' al final de 'repl?' en tu código original
-- se ignora ya que es un comentario o un error de sintaxis.