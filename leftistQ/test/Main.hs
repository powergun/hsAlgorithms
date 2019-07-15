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

-- MY NOTES
-- in order to call quickCheck :: Container -> Bool
-- it must implement the Arbitrary typeclass for the container 
-- type
-- No instance for (Arbitrary (Q.Queue Int))
-- arising from a use of ‘quickCheck’
-- L4261
-- at the heart of QuickCheck is the class Arbitrary, which has 
-- an arbitrary function to generate random instances of data 
-- types
-- class Testable prop where
--   property :: prop -> Property
-- instance [safe] (Arbitrary a, Show a, Testable prop) =>
--   Testable (a -> prop)
-- L4261
-- if we have a Testable property and an Arbitrary instance of a
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- then we can test a function a -> prop
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
heapOrdered :: Ord a => Q.Queue a -> Bool
heapOrdered Q.Empty = True
heapOrdered (Q.Queue _ _ Q.Empty Q.Empty) = True
heapOrdered (Q.Queue _ v Q.Empty r@(Q.Queue _ rv _ _)) =
  and [ v <= rv, heapOrdered r ]
heapOrdered (Q.Queue _ v l@(Q.Queue _ lv _ _) Q.Empty) =
  and [ v <= lv, heapOrdered l ]
heapOrdered (Q.Queue _ v l@(Q.Queue _ lv _ _) r@(Q.Queue _ rv _ _)) =
  and [ v <= rv, v <= lv, heapOrdered l, heapOrdered r ]

main :: IO ()
main = do
  print 
    "//////// verify leftist property /////////////////////////"
  quickCheck (verifyLeftist :: Q.Queue Int -> Bool)
  print
    "//////// verify heap order property //////////////////////"
  quickCheck (heapOrdered :: Q.Queue Int -> Bool)
