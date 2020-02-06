module PurelyStreamSpec (spec) where

import           Test.Hspec

import qualified PurelyFDS.Stream as Stream

spec :: IO ()
spec = hspec $ do
  describe "Simple Lazy Stream" $ do
    it "fromList -> toList roundtrip" $ do
      let l = [1..100]
      (Stream.toList . Stream.fromList $ l) `shouldBe` l
