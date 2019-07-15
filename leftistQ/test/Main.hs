import Test.QuickCheck

-- haskell cookbook L4191
-- quick check lib generates tests; we write properties that 
-- should be verified by quick check

-- generate arbitrary instances of queues
-- take a list of values and generate a queue out of it using 
-- the gen monad

import qualified Lib as Q

qFromList :: Ord a => [a] -> Gen (Q.Queue a)
qFromList xs =
  return (foldr Q.insertQ Q.emptyQ xs)

instance (Arbitrary a, Ord a) => Arbitrary (Q.Queue a) where
  arbitrary = do
    aList <- listOf arbitrary
    qFromList aList

-- L4211
-- verify the claim about the leftist property of the tree
-- write a function that takes a tree and verifies that each 
-- node follows the leftist property
verifyLeftist :: Q.Queue a -> Bool
verifyLeftist Q.Empty = True
verifyLeftist q@(Q.Queue rnk v l r) =
  and [ qRank q == rnk
      , qRank l >= qRank r 
      , verifyLeftist l
      , verifyLeftist r ]
  where
    qRank :: Q.Queue a -> Int
    qRank Q.Empty = 0
    qRank (Q.Queue _ _ l r) =  1 + minimum [qRank l, qRank r]

-- test the heap order property of the queue
heapOrdered :: Ord a => Queue a -> Bool
heapOrdered

main :: IO ()
main = do
  print 
    "//////// verify leftist property /////////////////////////"
  quickCheck (verifyLeftist :: Q.Queue Int -> Bool)
