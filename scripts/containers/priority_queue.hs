#!/usr/bin/env stack runghc

-- haskell cookbook L4093
-- many collections and data structures require binary tree as 
-- a basic ingredient

-- L4093
-- a leaftist heap:
-- a heap-ordered binary tree
-- the value at the node is less than or equal to the values of
-- children. 
-- A priority queue is used where we are always interested in 
-- the minimum element in the collection and would like to 
-- extract or remove it from the collection

-- the leftist priority queue obeys leftist property:
-- the rank of a left child is greater than or equal to the rank
-- of a right child
-- the rank of a node is the length of the rightmost path from
-- the node to an empty node
-- this path is called the right spine of the node
-- as a result of the leftist property, we get a tree where the 
-- right spine of any node is always the shortest path to an 
-- empty node

-- L4128
-- there are two instances when the leftist property will be 
-- violated
-- 1) insert
-- 2) delete
-- in both cases we have to take the violated path (where the 
-- rank of the left child is less than the rank of the right 
-- child) and readjust the elements
-- we will do this by merging two trees

-- see also
-- https://en.wikipedia.org/wiki/Leftist_tree

data Queue a = Empty
             | Queue Int a (Queue a) (Queue a)
             --      ^^^ rank info
             deriving (Show)

mergeQs :: Ord a => Queue a -> Queue a -> Queue a
mergeQs Empty q = q
mergeQs q Empty = q
mergeQs left@(Queue _ lv ll lr) right@(Queue _ rv rl rr) =
  if lv <= rv then
    swipe lv ll (mergeQs lr right)
  else 
    swipe rv rl (mergeQs left rr)

main :: IO ()
main = do
  print 1
