module PurelyFDS.Leftist where

data Heap a = Leaf
            | Node { rank :: Int
                   , elem :: a
                   , l    :: Heap a
                   , r    :: Heap a
                   }
            deriving (Eq, Ord, Show)
