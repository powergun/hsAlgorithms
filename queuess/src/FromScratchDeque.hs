module FromScratchDeque ( Queue(..), push, empty, length, pop ) where

import           Prelude hiding (length)

-- From Okasaki's Purely Functional Data Structures
data Queue a = Queue
  { enqueue :: [a]
  , dequeue :: [a]
  } deriving (Eq, Show)

empty :: Queue a
empty = Queue [] []

length :: Queue a -> Int
length = (foldr (\elem summ -> summ + 1) 0) . enqueue

push :: a -> Queue a -> Queue a
push elem q = Queue (elem : enqueue q) (reverse . (elem :) . reverse . dequeue $ q)

pop :: Queue a -> Maybe (a, Queue a)
pop (Queue en de) =
  case (en, de) of
    ([], []) -> Nothing
    _        -> Just (last en, Queue (init en) (tail de))
