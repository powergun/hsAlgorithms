module BinomialSpec (spec) where

import           Test.Hspec

import qualified PurelyFDS.Binomial as Binomial

spec :: IO ()
spec = hspec $ do
  let unordered = [3, 1, 4, 15, 9, 2, 6, 53, 5, 89, 7, 932, 38, 46, 26]
      simple = [3, 1]
  describe "Construct binomial heaps" $ do
    it "Create an empty heap from an empty list" $ do
      null (Binomial.fromList ([] :: String)) `shouldBe` True

    it "Create a heap from a simple list" $ do
      let hp = Binomial.fromList simple
      null hp `shouldBe` False

  describe "Find min from binomial heaps" $ do
    it "Find min from a simple hp" $ do
      let hp = Binomial.fromList unordered
      Binomial.findMin hp `shouldBe` Just 1

    it "Find min from merged hps" $ do
      let hp1 = Binomial.fromList unordered
          hp2 = Binomial.fromList [(-100), (-40)]
          hp = Binomial.merge hp1 hp2
      Binomial.findMin hp `shouldBe` Just (-100)
