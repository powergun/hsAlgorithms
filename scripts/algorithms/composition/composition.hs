#!/usr/bin/env stack runghc

f x = x + 10
g x = x * x

-- tacit programming "point free style"
-- https://en.wikipedia.org/wiki/Tacit_programming

demoTacitProgramming :: IO ()
demoTacitProgramming = do
    let f = filter (\x -> x > 0) . filter (\x -> x `mod` 3 == 0)
    print $ f [0, 1, 2, 3, 4, 5, 6]

main = do
    print $ map (g . f) [1, 2, 3]
    demoTacitProgramming
