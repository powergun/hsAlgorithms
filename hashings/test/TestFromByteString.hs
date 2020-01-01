{-# LANGUAGE OverloadedStrings #-}

module TestFromByteString where

import qualified FromByteString

import           Test.Hspec

demo :: IO ()
demo = hspec $ do
  describe "Create sha3-512 from bytestring" $ do
    it "Expect hexstring" $ do
      let hexs = FromByteString.hexSha3_512 "iddqd"
      hexs `shouldBe` "a1676f210740425851eae8871385dab11f718922f37837953d26b96be65becce9793d87507531265cb762d10133d79397f2bbfada2f17981160c8bfe9768ee66"

  describe "Create sha1 from word8 values" $ do
    it "Expect raw bytes (bytestring)" $ do
      let hexs = FromByteString.fromWord8s [1..10]
      hexs `shouldBe` "\197\&9\RS0\138\242[B\213\147Mj \SUB4\232\152\210U\198"
