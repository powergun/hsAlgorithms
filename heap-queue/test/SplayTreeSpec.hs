module SplayTreeSpec (spec) where

import           PurelyFDS.SplayTree
import           Test.Hspec

spec :: IO ()
spec = hspec $ do
  let l = [1..10000] ++ (fmap (* (-1)) [1..10000])
  describe "Splay Heap" $ do
    it "Expect partition" $ do
      let n = (Node (Node (Node Leaf 1 Leaf) 3 Leaf) 5 Leaf)
      print $ partition 2 n

    it "Expect find min" $ do
      let n = fromList l
      findMin n `shouldBe` Just (-10000)
