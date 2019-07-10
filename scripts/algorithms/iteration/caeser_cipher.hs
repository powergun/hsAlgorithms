#!/usr/bin/env stack runghc

import Data.Char

-- programming haskell L1701

toInt :: Char -> Int
toInt c = ord c - ord 'a'
toChar :: Int -> Char
toChar n = chr (ord 'a' + n)
cipher :: Int -> Char -> Char
cipher n c | isLower c = toChar ((toInt c + n) `mod` 26)
           | otherwise = c
caesarCipher :: Int -> String -> String
caesarCipher n s = [ cipher n c | c <- s ]
demoCaesarCipher :: IO ()
demoCaesarCipher = do
    print $ caesarCipher 324 "there is a cow"
    print $ caesarCipher (-324) "ftqdq ue m oai"

main :: IO ()
main = do
    demoCaesarCipher
