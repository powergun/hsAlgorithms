#!/usr/bin/env stack runghc

-- source
-- https://wiki.haskell.org/99_questions/Solutions/1

last1 [] = Nothing
last1 ns = Just $ (head . reverse) ns

last2 []     = Nothing
last2 [x]    = Just x
last2 (_:xs) = last2 xs

last3 [] = Nothing
-- foldr1
-- http://zvon.org/other/haskell/Outputprelude/foldr1_f.html
-- it takes the last two items of the list and applies the
-- function, then it takes the third item from the end and the
-- result, and so on. See scanr1 for intermediate results
-- (const id) has the same behavior as (flip const)
-- see
-- https://stackoverflow.com/questions/8745045/the-behavior-of-const-id
last3 xs = Just (foldr1 (const id) xs)

last4 [] = Nothing
-- foldl1
-- http://zvon.org/other/haskell/Outputprelude/foldl1_f.html
-- it takes the first 2 items of the list and applies the function
-- to them, then feeds the function with this result and the third
-- argument and so on. See scanl1 for intermediate results.
--
-- curry converts an uncurried function to a curried function
-- http://zvon.org/other/haskell/Outputprelude/curry_f.html
--
-- Prelude> a = curry snd
-- Prelude> :t a
-- a :: a -> c -> c
-- Prelude> :t snd
-- snd :: (a, b) -> b
-- Prelude> :t curry
-- curry :: ((a, b) -> c) -> a -> b -> c
last4 xs = Just (foldl1 (curry snd) xs)

last5 [] = Nothing
last5 xs = Just (xs !! ((length xs) - 1))

verify :: ([Int] -> Maybe Int) -> IO ()
verify f = do
  assert Nothing $ f ([] :: [Int])
  assert (Just 111) $ f [111]
  assert (Just 6) $ f [1..6]
  where
    assert lhs rhs =
      case (lhs == rhs) of
        True  -> return ()
        False -> error $ "fail: " ++ show lhs ++ " != " ++ show rhs

main :: IO ()
main = do
  verify last1
  verify last2
  verify last3
  verify last4
  verify last5
