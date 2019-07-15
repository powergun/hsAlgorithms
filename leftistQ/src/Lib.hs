module Lib
    ( emptyQ
    , popQ
    , popNQ
    , insertQ
    , insertAllQ
    , minimumQ
    ) where

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
                     --  .. node value
             | Queue Int a (Queue a) (Queue a)
             --      ^^^ rank info
             deriving (Show)

mergeQs :: Ord a => Queue a -> Queue a -> Queue a
mergeQs Empty q = q
mergeQs q Empty = q
mergeQs left@(Queue _ lv ll lr) right@(Queue _ rv rl rr) =
  if lv <= rv then
    checkAndSwipe lv ll (mergeQs lr right)
  else 
    checkAndSwipe rv rl (mergeQs left rr)

-- MY NOTES:
-- just a getter function; not log(n) computation, which is done
-- at the post merge re-adjustment stage
rank :: Queue a -> Int
rank Empty = 0
rank some@(Queue r _ _ _) = r

-- L4141
-- swipe function is to check the rank and swipe left and right 
-- branches to obey the leftist property
checkAndSwipe :: a -> Queue a -> Queue a -> Queue a
checkAndSwipe v left right =
  let lRank = rank left
      rRank = rank right
  in if lRank >= rRank
     then
       Queue (rRank + 1) v left right
     else
       Queue (lRank + 1) v right left

emptyQ :: Queue a
emptyQ = Empty

singletonQ :: a -> Queue a
singletonQ v = Queue 1 v Empty Empty

insertQ :: Ord a => a -> Queue a -> Queue a
insertQ v q =
  mergeQs (singletonQ v) q

insertAllQ :: Ord a => [a] -> Queue a -> Queue a
insertAllQ [] q = q
insertAllQ (x:xs) q =
  let q' = insertQ x q
  in insertAllQ xs q'

minimumQ :: Queue a -> Maybe a
minimumQ Empty = Nothing
minimumQ (Queue _ v _ _) = Just v

popQ :: Ord a => Queue a -> Maybe (Queue a, a)
popQ Empty = Nothing
popQ (Queue _ v l r) = 
  let q = mergeQs l r
  in Just (q, v)

popNQ :: Ord a => Queue a -> Int -> Maybe (Queue a, a)
popNQ Empty _ = Nothing
popNQ q@(Queue _ v _ _) 0 = Just (q, v)
popNQ q@(Queue _ v l r) ntimes =
  let Just (q', _) = popQ q
  in popNQ q' (ntimes - 1)