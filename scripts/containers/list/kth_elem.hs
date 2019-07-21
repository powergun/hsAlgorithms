#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/3

import           Helpers (forM_, verify1)

kth1 [] _ = Nothing
kth1 xs i | i < 0 = Nothing
          -- won't work with infinite list!
          | i >= length xs = Nothing
          | otherwise = Just (xs !! (i - 1))

main :: IO ()
main = do
  let condidates = [ ([], 1, Nothing)
                   , ([1], -1, Nothing)
                   , ([1], 23, Nothing)
                   , ([1..9], 5, Just 5)
                   , ([1..101], 100, Just 100)

                   -- length xs will cause this to freeze
                   -- , ([1..], 100, Just 100)
                   ]
  forM_ [ kth1
        ] $ \f ->
    verify1 f condidates
