{-# LANGUAGE OverloadedStrings #-}

module FromByteString where

import           Crypto.Hash
import qualified Crypto.Hash.SHA1 as SHA1
import           Data.ByteString
import           Data.Word
import           Prelude          hiding (map)

sha1 :: ByteString -> Digest SHA1
sha1 = hash

fromWord8s :: [Word8] -> ByteString
fromWord8s xs = SHA1.hash . Data.ByteString.pack $ xs

hexSha3_512 :: ByteString -> String
hexSha3_512 bs = show (hash bs :: Digest SHA3_512)
