{-# LANGUAGE OverloadedStrings #-}

module FirstPrinciples.ByteStringZip (demo) where
import qualified Data.ByteString.Lazy   as BL
import qualified Data.Text.Encoding     as TE
import qualified Data.Text.IO           as TIO

-- https://hackage.haskell.org/package/zlib
import qualified Codec.Compression.GZip as GZip

input :: BL.ByteString
input = "123"

compressed :: BL.ByteString
compressed = GZip.compress input

demo :: IO ()
demo = do
  print "//// ByteString as a generic data carrier"
  let s = BL.toStrict
  TIO.putStrLn $ TE.decodeUtf8 (s input)

  -- runtime error:
  -- there’ll be a byte that isn’t recog- nizably correct as an
  -- encoding of text information
  -- TIO.putStrLn $ TE.decodeUtf8 (s compressed)
  print compressed
