#!/usr/bin/env stack runghc

qsort [] = []
-- always pick the first element
-- recall some form of this algorithm (in cracking coding interview
-- for example) uses the same logic in C or Java
-- qsort :: Ord a => [a] -> [a]
-- Ord a is deduced by the compiler,
-- programming haskell L535
-- "clear and concise"
-- I second that!!
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
    where
        smaller = [a | a <- xs, a <= x]
        larger = [b | b <- xs, b > x]

main :: IO ()
main = do
    -- print $ qsort [3, 1, 4, 1, 5, 9, 2, 6]
    -- works with [Char]/String too: cdddeehiioqrstw
    print $ qsort "thereiscowiddqd"
