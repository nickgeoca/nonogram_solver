module NonogramSolver (solve) where

import Control.Monad
import Data.List
import Data.List.Split

-- >>> getValidRowGuesses [] [[[0,0,0]],[[1,0,0],[0,1,0],[0,0,1]]] [[],[],[1]]
-- [[0,0,0],[0,0,1]]
getValidRowGuesses :: [[Int]] -> [[[Int]]] -> [[Int]] -> [[[Int]]]
getValidRowGuesses guess [] _ = return guess
getValidRowGuesses guess (validRowStates:nextValidRowsStates) constraintColumns = 
  do validRowState <- validRowStates
     let newGuess = guess ++ [validRowState]
     getValidRowGuesses newGuess nextValidRowsStates constraintColumns


-- >>> or $ map (== (validRowStates 5 [2,1])) (permutations [[1,1,0,1,0], [1,1,0,0,1], [0,1,1,0,1]])
-- True
-- >>> or $ map (== (validRowStates 4 [1,1])) (permutations [[1,0,1,0], [1,0,0,1], [0,1,0,1]])
-- True
-- >>> or $ map (== (validRowStates 4 [])) (permutations [[0,0,0,0]])
-- True
validRowStates :: Int -> [Int] -> [[Int]]
validRowStates rowLen rowRunsOn = 
    case length rowRunsOn of
         0 -> let allZeros = replicate rowLen 0
              in  return allZeros    
         _ -> let lenInner = length rowRunsOn - 1
                  isFn = innersConstrainedSum lenInner
                  osFn = outersConstrainedSum
                  sumsInner = [0.. (rowLen - sum rowRunsOn)]
                  sumsOuter = reverse sumsInner
                  iss = map isFn sumsInner
                  oss = map osFn sumsOuter
                  ioss = zip iss oss in
              do (is, os) <- ioss   
                 (start, end) <- os
                 inner <- is
                 let startOffs = replicate start 0
                     endOffs   = replicate end 0
                     innerOffs = map (flip replicate 0) inner
                     rowOns    = map (flip replicate 1) rowRunsOn
                 return $ concat $ startOffs : blend rowOns (innerOffs ++ [endOffs]) 
  where
  combinations n k inputSet = [set | set <- mapM (const inputSet) [1..k]]
  -- combinations n k: (n>=ints>=1) that sum to n
  innersConstrainedSum len sum' = [set   | set <- combinations sum' len [1..sum']
                                         , sum set == sum']
  outersConstrainedSum     sum' = [(x,y) | x <- [0..sum'] 
                                         , y <- [0..sum'] 
                                         , x + y == sum'] 
  blend (x:xs) ys = x:(blend ys xs)
  blend _ _ = []

solve :: [[Int]] -> [[Int]] -> Maybe [[Int]]
solve constraintColumns constraintRows = headMaybe $ 
  do validRowGuess <- getValidRowGuesses [] validRowsStates constraintColumns
     stopIfInvalidColumns validRowGuess
     return validRowGuess 
  where
  -- Validate column constraint runs
  stopIfInvalidColumns :: [[Int]] -> [()]
  stopIfInvalidColumns guess = guard $ and $
    do (guessCol, constraintCol) <- zip (transpose guess) constraintColumns
       let guessColRuns = map sum $ filter (/=[]) $ splitWhen (==0) guessCol
       return $ guessColRuns == constraintCol
  rowLen = length constraintColumns
  validRowsStates :: [[[Int]]]
  validRowsStates = map (validRowStates rowLen) constraintRows
  headMaybe [] = Nothing
  headMaybe (x:_) = Just x
