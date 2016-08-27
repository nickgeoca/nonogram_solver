module Main where

import NonogramSolver
import System.IO

main :: IO ()
main = 
  do col <- getInput "Column constraints: "
     row <- getInput "Row constraints: "
     case solve col row of
        Nothing -> print "No valid solution found!"
        Just solution -> mapM_ putStrLn [[if e==0 then '-' else 'X' | e <- row'] | row' <- solution]
  where
  getInput s = do putStr s
                  hFlush stdout 
                  readLn
