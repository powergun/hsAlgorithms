{-# LANGUAGE NoImplicitPrelude #-}

module FromScratch ( DList (..), empty, length, singleton
                   , cons, snoc, toList, append ) where

import           Prelude hiding (length)

newtype DList a = DL { unDL :: [a] -> [a] }

empty :: DList a
empty = DL id

length :: DList a -> Int
length = (foldr (\elem summ -> summ + 1) 0) . toList

singleton :: a -> DList a
singleton x = DL (x :)

toList :: DList a -> [a]
toList dl = unDL dl []

-- Prepend a single element to a dlist.
infixr `cons`
cons :: a -> DList a -> DList a
cons x xs = DL ((x:) . unDL xs)

-- Append a single element to a dlist.
infixl `snoc`
snoc :: DList a -> a -> DList a
snoc dl x = DL $ \src -> mappend (unDL dl src) [x]

-- Append dlists.
append :: DList a -> DList a -> DList a
append l r = DL $ \src -> mappend (unDL l src) (unDL r [])
