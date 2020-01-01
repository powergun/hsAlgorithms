{-# LANGUAGE OverloadedStrings #-}

module FromByteString where

import           Crypto.Hash
import           Data.ByteString
import           Data.Word
import           Prelude         hiding (map)

sha1 :: ByteString -> Digest SHA1
sha1 = hash

fromWord8s :: [Word8] -> String
fromWord8s xs = let a = (hash $ Data.ByteString.pack xs) :: Digest SHA1
                in show a

hexSha3_512 :: ByteString -> String
hexSha3_512 bs = show (hash bs :: Digest SHA3_512)
