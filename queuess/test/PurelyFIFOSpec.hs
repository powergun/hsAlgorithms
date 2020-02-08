module PurelyFIFOSpec (spec) where

import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  describe "" $ do
    it "" $ do
      1 `shouldBe` 1
