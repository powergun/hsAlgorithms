module WeightBiasedSpec (spec) where

import qualified Data.List              as List
import           Test.Hspec

import qualified PurelyFDS.WeightBiased as Weight

spec = hspec $ do
  let unordered = [3, 1, 4, 15, 9, 2, 6, 53, 5, 89, 7, 932, 38, 46, 26]
      simple = [3, 1]
  describe "Construct Weight-Biased heap" $ do

    it "Create leaf from an empty list" $ do
      Weight.fromList "" `shouldBe` (Weight.Leaf :: Weight.Heap Char)

    it "Create a heap from a list, Expect root (smallest)" $ do
      let hq = Weight.fromList unordered
          o = Weight.pop hq
      case o of
        Just (x, _) -> x `shouldBe` 1
        _           -> error "FAILED!!"

    it "Heapsort" $ do
      Weight.sort unordered `shouldBe` List.sort unordered
