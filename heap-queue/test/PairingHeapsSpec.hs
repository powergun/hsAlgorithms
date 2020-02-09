module PairingHeapsSpec (spec) where

import           Test.Hspec

import           PurelyFDS.PairingHeaps

spec :: IO ()
spec = hspec $ do
  let l = [1..10000] ++ (fmap (* (-1)) [1..10000])
  describe "Pairing Heaps" $ do
    it "Expect find min" $ do
      let n = fromList l
      findMin n `shouldBe` Just (-10000)
