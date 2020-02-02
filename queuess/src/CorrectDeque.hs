module CorrectDeque ( Queue(..), push, empty, length, pop
                    , enqueue, dequeue ) where

import           Prelude hiding (length)

-- From Okasaki's Purely Functional Data Structures
data Queue a = Queue [a] [a] deriving (Eq, Show)

empty :: Queue a
empty = Queue [] []

length :: Queue a -> Int
length (Queue en de) =
  let enlength = foldr (\elem summ -> summ + 1) 0 en
      delength = foldr (\elem summ -> summ + 1) 0 de
  in enlength + delength

push :: a -> Queue a -> Queue a
push elem (Queue en de) = Queue (elem : en) (de)

enqueue :: Queue a -> [a]
enqueue (Queue en de) = mappend en (reverse de)

dequeue :: Queue a -> [a]
dequeue (Queue en de) = mappend de (reverse en)

pop :: Queue a -> Maybe (a, Queue a)
pop (Queue en de) =
  case de of
    [] -> case (Queue de (reverse en)) of
            (Queue _ [])  -> Nothing
            (Queue _ de') -> Just ((head de'), (Queue [] $ tail de'))
    _ -> Just ((head de), (Queue en $ tail de))
