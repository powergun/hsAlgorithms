#!/usr/bin/env stack runghc

-- haskell design pattern P/58
-- recursive types

-- mentioned in real world haskell P/329
-- haskell's combination of algebraic data types, pattern matching 
-- and guards reduce even the hairiest of balancing operations 
-- to a few lines of code

-- the attraction of a tree to a functional programmer is cheap
-- modification. We don't break the immutability rule: tree are 
-- immutable just like everything else. However when we modify 
-- a tree, thus creating a new tree, we can share most of the 
-- structure between the old and new versions. For example, in 
-- a tree containing 10000 nodes, we might expect that the old 
-- and new versions will share about 9985 elements when we
-- add or remove one. In other words, the number of elements 
-- modified per update depends on the height of the tree or 
-- the logarithm of the size of the tree

-- haskell 's standard libraries provide two collection types 
-- that are implemented using balanced trees behind the scenes: 
-- Data.Map for key/value pairs and Data.Set for sets of values

-- P/329
-- compared to a hash table, a well-implemented purely functional 
-- tree data structure will perform competitively. You should not
-- approach trees with assumption that your code will pay a 
-- performance penalty.

data Tree a = Leaf a | Branch (Tree a) (Tree a)
    deriving (Show, Eq)

-- functions over recursive types are typically recursive 
-- themselves
size :: Tree a -> Int
size (Leaf x) = 1
size (Branch t u) = size t + size u + 1

demoSimpleTree :: IO ()
demoSimpleTree = do
    ; print tree
    ; print $ size tree
    where
        tree = Branch (Leaf 1) (Leaf 2)

main :: IO ()
main = do
    demoSimpleTree
