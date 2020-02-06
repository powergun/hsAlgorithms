module PurelyRBTreeSpec (spec) where

import           Data.List        (sort)
import           Test.Hspec

import qualified PurelyFDS.RBTree as RBTree

spec :: IO ()
spec = hspec $ do
  let unordered = [3, 1, 4, 15, 9, 2, 6, 53, 5, 89, 7, 932, 38, 46, 26]
  describe "RB-Tree sort" $ do
    it "Sort a simple list" $ do
      RBTree.sort unordered `shouldBe` sort unordered
