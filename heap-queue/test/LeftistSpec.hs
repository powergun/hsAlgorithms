module LeftistSpec (spec) where

import qualified Data.List         as List
import           Test.Hspec

import qualified PurelyFDS.Leftist as Leftist

spec = hspec $ do
  let unordered = [3, 1, 4, 15, 9, 2, 6, 53, 5, 89, 7, 932, 38, 46, 26]
      simple = [3, 1]
  describe "Construct leftist heap" $ do

    it "Create leaf from an empty list" $ do
      Leftist.fromList "" `shouldBe` (Leftist.Leaf :: Leftist.Heap Char)

    it "Create a heap from a list, Expect root (smallest)" $ do
      let hq = Leftist.fromList unordered
          o = Leftist.pop hq
      case o of
        Just (x, _) -> x `shouldBe` 1
        _           -> error "FAILED!!"

    it "Heapsort" $ do
      Leftist.sort unordered `shouldBe` List.sort unordered
