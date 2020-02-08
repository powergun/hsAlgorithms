module PurelyFDS.FIFO where

import           Prelude hiding (head, last, length, tail)
import qualified Prelude

data Queue a = Queue [a] [a]

empty = Queue [] []

head :: Queue a -> Maybe a
head (Queue (f:fs) s) = Just f
head (Queue [] [])    = Nothing

tail :: Queue a -> Queue a
-- tail (Queue [x] r)    = Queue (reverse r) []  -- invariant
-- tail (Queue (f:fs) r) = Queue fs r
tail (Queue (f:fs) r) = checkf (Queue fs r)

cons :: a -> Queue a -> Queue a
cons x (Queue f r) = Queue (x:f) r

snoc :: Queue a -> a -> Queue a
-- snoc (Queue [] _) x = Queue [x] []  -- invariant
-- snoc (Queue f r) x  = Queue f (x:r)
snoc (Queue f r) x = checkf (Queue f (x:r))

-- to maintain the invariant
checkf :: Queue a -> Queue a
checkf (Queue [] r) = Queue (reverse r) []
checkf q            = q

length :: Queue a -> Int
length (Queue f r) = Prelude.length f + Prelude.length r

fromList :: [a] -> Queue a
fromList = foldr cons empty

pop :: Queue a -> Maybe (a, Queue a)
pop (Queue [] []) = Nothing
pop (Queue (f:fs) r) =
  let q' = checkf (Queue fs r)
  in Just (f, q')

toList :: Queue a -> [a]
toList q =
  case pop q of
    Just (x, q') -> x : toList q'
    _            -> []
