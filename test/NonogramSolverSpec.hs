module NonogramSolverSpec (spec) where

import NonogramSolver
import Test.Hspec

spec :: Spec
spec = do
  describe "solve" $ do
    it "has the correct function type" $ do
       solve ([]:: [[Int]]) ([]:: [[Int]]) `shouldBe` (Just [] :: Maybe [[Int]])
    it "returns a picture [] for 0-d row/col input" $ do
       solve [] [] `shouldBe` (Just [] :: Maybe [[Int]])
    it "returns a picture [[0]] for appropriate 1-d row/col input" $ do
       solve [[]] [[]] `shouldBe` Just [[0]]
    it "solves a 4x4 example correctly" $ do
       solve [[1],[1],[1],[1]] [[1],[1],[1],[1]] `shouldBe` Just [[1,0,0,0]
                                                                 ,[0,1,0,0] 
                                                                 ,[0,0,1,0]
                                                                 ,[0,0,0,1]]
    it "sovles a 4x4 example correctly" $ do
       solve [[2],[2],[2],[2]] [[2],[2],[2],[2]] `shouldBe` Just [[1,1,0,0]
                                                                 ,[1,1,0,0] 
                                                                 ,[0,0,1,1] 
                                                                 ,[0,0,1,1]]
    it "returns nothing for unsolvable puzzles" $ do
       solve [[3]] [[3]] `shouldBe` Nothing
    it "inputs the column and row parameters in correct position (i.e. row is not input as column, etc)" $ do
       solve [[],[],[1]] [[],[1]] `shouldBe` Just [[0,0,0]
                                                  ,[0,0,1]]
