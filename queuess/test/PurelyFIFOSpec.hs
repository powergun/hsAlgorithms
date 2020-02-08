module PurelyFIFOSpec (spec) where

import qualified PurelyFDS.FIFO as FIFO
import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  let l = [1..10]
  describe "Construct FIFO" $ do
    it "Create from list, expect length" $ do
      (FIFO.length . FIFO.fromList $ l) `shouldBe` length l

    it "Create list from queue" $ do
      let l' = FIFO.toList . FIFO.fromList $ l
      l' `shouldBe` l
