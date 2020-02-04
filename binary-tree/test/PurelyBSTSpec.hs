module PurelyBSTSpec (spec) where

import           PurelyFDS.BST

import           Data.List     (sort)
import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  let emptyList = [] :: [Int]
      leaf = Leaf :: Tree Int
      unordered = [3, 1, 4, 15, 9, 2, 6, 53, 5, 89, 7, 932, 38, 46, 26]
  describe "Create tree, expect pre-order" $ do
    it "Expect leaf created from an empty list" $
      fromList' emptyList `shouldBe` leaf
    it "Expect pre-order from a singleton tree" $ do
      let tree = insert' 10 (Node Leaf 1 Leaf)
          tree' = insert'' 10 (Node Leaf 1 Leaf)
      preorder' tree `shouldBe` [1, 10]
      preorder' tree' `shouldBe` [1, 10]
    it "Expect pre-order from a tree created from an unordered list" $ do
      let tree = fromList' unordered
      preorder' tree `shouldBe` sort unordered

  describe "Membership check" $ do
    it "Expect a member" $ do
      member' 53 (fromList' unordered) `shouldBe` True
      member'' 53 (fromList' unordered) `shouldBe` True
    it "Expect not a member" $ do
      member' 100 (fromList' unordered) `shouldBe` False
      member' 100 leaf `shouldBe` False
      member'' 100 (fromList' unordered) `shouldBe` False
      member'' 100 leaf `shouldBe` False
