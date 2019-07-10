#!/usr/bin/env stack runghc

-- haskell design pattern P/54 tail recursion
-- recursion can be viewed as a pattern for avoiding a mutable
-- state

-- P/53
-- need to hold the entire list (stack) in memory to perform the 
-- sum
sumNontail :: Num a => [a] -> a
sumNontail [] = 0
sumNontail (x:xs) = x + sumNontail xs
-- the last thing executed: x + sum-elems-remain
-- sumNontail (the function itself) is not the last thing executed
demoNontailRecursion :: IO ()
demoNontailRecursion = do
    print "//// demo non-tail recursion"
    print $ sumNontail [1, 2, 3, 4, 5]

-- tail recursion addresses the exorbitant use of space
-- less mathematical induction-looking
-- even through recursive, it expresses an iterative process

-- see:
-- https://www.geeksforgeeks.org/tail-recursion/
-- What is tail recursion?
-- A recursive function is tail recursive when recursive call is 
-- the last thing executed by the function. 
-- ^^^^^^^^^^^^^^^^^^^^^^^ 
sumTail :: Num a => a -> [a] -> a
sumTail x [] = x
sumTail acc (x:xs) = sumTail (acc + x) xs
-- the last thing executed: sumTail sum-so-far elems-remain
demoTailRecursion :: IO ()
demoTailRecursion = do
    print "//// demo tail recursion"
    print $ sumTail 0 [1, 2, 3, 4, 5]

-- P/55 
-- tail recursion is captured by foldl function
-- foldl expands in exactly the same way as sumTail
-- in contrastm foldrSum expands in the same way as sumNonTail
demoFoldl :: IO ()
demoFoldl = do
    print "//// demo fold-left"
    --            op init values
    print $ foldl (+) 0 [1, 2, 3, 4, 5]

-- real world haskell P/245
-- why tail recursion matters (why it's preferred)
-- if we demand an element of the expression "foo" ++ "bar",
-- the first pattern fo the function's definition matches, 
-- and we return the expression x : (xs ++ ys).
-- Because the (:) constructor is nonstrict, the evaluation of 
-- xs ++ ys can be deferred: we generate more elements of the 
-- result at whatever rate they are demanded. When we generate
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- more of the result, we will no longer be using x, so the 
-- garbage collector can reclaim it. Since we generate elements 
-- of the result on demand, and do not hold onto parts that
-- we are done with, the compiler can evaluate our code in 
-- constant space
main :: IO ()
main = do
    demoNontailRecursion
    demoTailRecursion
    demoFoldl
