module FromScratchDequeSpec (spec) where

import           Test.Hspec

import qualified FromScratchDeque as Q

spec :: IO ()
spec = hspec $ do
  describe "Construct queue and initial properties" $ do
    it "Create empty queue" $ do
      let q = Q.empty
      Q.length q `shouldBe` 0

  describe "Push elem" $ do
    let q1 = Q.push "e1m1" Q.empty
        q2 = Q.push "imp" q1
        q3 = Q.push "gunner" q2
    it "expect length" $ do
      Q.length q3 `shouldBe` 3
    it "expect enqueue" $ do
      Q.enqueue q3 `shouldBe` ["gunner", "imp", "e1m1"]
    it "expect dequeue" $ do
      Q.dequeue q3 `shouldBe` ["e1m1", "imp", "gunner"]

  describe "Pop elem" $ do
    let q1 = Q.push "e1m1" Q.empty
        q2 = Q.push "imp" q1
        q3 = Q.push "gunner" q2
    it "Pop, expect elem and new Queue" $ do
      case Q.pop q3 of
        Just (elem, q') -> do
          elem `shouldBe` "e1m1"
          Q.enqueue q' `shouldBe` ["gunner", "imp"]
        _ -> error "FAIL!!!"
    it "Pop more" $ do
      case Q.pop q2 of
        Just (elem, q') -> do
          elem `shouldBe` "e1m1"
          Q.enqueue q' `shouldBe` ["imp"]
        _ -> error "FAIL!!!"
    it "Pop even more, expect Nothing" $ do
      Q.pop (Q.empty :: Q.Queue String) `shouldBe` Nothing

