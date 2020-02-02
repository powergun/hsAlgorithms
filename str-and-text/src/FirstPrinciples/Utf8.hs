{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module FirstPrinciples.Utf8 (demo) where

import qualified Data.ByteString       as B
import qualified Data.ByteString.Char8 as B8
import           Data.Char             (ord)
import qualified Data.Text             as T
import qualified Data.Text.Encoding    as TE
import           Text.RawString.QQ     (r)

-- Manual unicode encoding of Japanese text
-- GHC Haskell allows UTF8 in source files
-- generated on: https://www.branah.com/unicode-converter
-- tested by: https://docs.python.org/3/howto/unicode.html
s :: String
s = "\12371\12435\12395\12385\12399\12289\
\20803\27671\12391\12377\12363\65311"

s2 :: String
s2 = "\36825\37324\26377\19968\21482\29275"

bs' :: B.ByteString
bs' = "\xe8\xbf\x99\xe9\x87\x8c\xe6\x9c\x89\xe4\xb8\x80\xe5\x8f\xaa\xe7\x89\x9b"

bs :: B.ByteString
bs = mconcat [ "\xe8\xbf\x99\xe9\x87\x8c\xe6\x9c\x89"
             , "\xe4\xb8\x80\xe5\x8f\xaa\xe7\x89\x9b"
             ]

utf8ThenPrint :: B.ByteString -> IO ()
utf8ThenPrint = putStrLn . T.unpack . TE.decodeUtf8

toCodePoints :: String -> [Int]
toCodePoints = fmap ord

-- test this with any chinese/japanese characters
printCodePoints :: String -> IO ()
printCodePoints s = putStrLn $ mconcat $ fmap (("\\" ++) . show . ord) s

demo :: IO ()
demo = do
  print "//// UTF8 Encode/Decode"
  utf8ThenPrint bs
  -- Text is UTF-16
  utf8ThenPrint . TE.encodeUtf8 . T.pack $ s
  print $ toCodePoints "这里"
  -- printCodePoints s2
  utf8ThenPrint . TE.encodeUtf8 . T.pack $ s2
