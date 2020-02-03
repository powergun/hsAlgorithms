module PurelyFDSListsSpec (spec) where

import           PurelyFDS.Lists

import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  describe "Update i-th element" $ do
    it "Indice out of range, expect no change" $
      update' [1, 2, 3] 5 999 `shouldBe` [1, 2, 3]
    it "Indice out of range (negative), expect no change" $
      update' [1, 2, 3] (-5) 999 `shouldBe` [1, 2, 3]
    it "Indice in range, expect new list" $
      update' [1, 2, 3] 2 999 `shouldBe` [1, 2, 999]
    it "Empty list, expect empty list" $ do
      let a = [] :: [Int]
      update' a 2 999 `shouldBe` []

  describe "Suffixes" $ do
    it "" $
      suffixes' [1,2,3,4] `shouldBe` [[1,2,3,4], [2,3,4], [3,4], [4], []]
