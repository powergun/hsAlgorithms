#!/usr/bin/env stack runghc

-- programming haskell L2660

trimOrExtend :: Int -> [Int] -> [Int]
trimOrExtend n ns = take n (ns ++ repeat 0)
demoTrimOrExtend :: IO ()
demoTrimOrExtend = do
    print "demo trim or extend"
    print $ trimOrExtend 4 [3, 1, 4, 1, 5, 2, 6]
    print $ trimOrExtend 4 [3]

main :: IO ()
main = do
    demoTrimOrExtend
