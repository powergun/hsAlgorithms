module FromScratchSpec (spec) where

import qualified FromScratch as DL
import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  describe "Construct DList and initial properties" $ do
    it "Create an empty list, expect length" $ do
      let dl = DL.empty
      DL.length dl `shouldBe` 0
    it "Create an singleton list, expect length" $ do
      let dl = DL.singleton "e1m1"
      DL.length dl `shouldBe` 1

  describe "Prepend elem to DList" $ do
    it "Prepend an element to a singleton dlist" $ do
      let l1 = DL.singleton "e1m1"
      DL.length ("doom" `DL.cons` l1) `shouldBe` 2
      DL.toList ("doom" `DL.cons` l1) `shouldBe` ["doom", "e1m1"]

  describe "Append elem to DList" $ do
    it "Append an element to a singleton dlist" $ do
      let l1 = DL.singleton "e1m1"
      DL.length (l1 `DL.snoc` "e1m2") `shouldBe` 2
      DL.toList (l1 `DL.snoc` "e1m2") `shouldBe` ["e1m1", "e1m2"]

  describe "Append DList to DList" $ do
    it "Append Left to Right" $ do
      let l1 = DL.cons "e1" $ DL.singleton "m1"
          l2 = DL.cons "e2" $ DL.singleton "m2"
      DL.toList (DL.append l1 l2) `shouldBe` ["e1", "m1", "e2", "m2"]
