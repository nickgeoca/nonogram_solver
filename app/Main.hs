module Main where

import NonogramSolver

main :: IO ()
main = 
  do (col, row) <- readLn
     print $ case solve col row of
                Nothing -> "No valid solution found!"
                Just solution -> show solution
