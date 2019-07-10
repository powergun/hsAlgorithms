#!/usr/bin/env stack runghc

main = print $ foldr (+) 0 [3, 1, 4]
