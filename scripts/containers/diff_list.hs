#!/usr/bin/env stack runghc

import Data.Monoid

-- real world haskell P/358
-- using these partial functions to store data, which we can 
-- retrieve by providing an empty list; Each partial function of 
-- (++) and (.) represents an append, but it DOES NOT actually
-- perform the append
-- A) the cost of a partial application is constant, so the cost
--   of many partial applications is linear
-- B) when we finally provide a [] value to unlock the final list
--   from its chain of partial applications, application proceeds
--   from right to left. This keeps the left operand (++) small
--   and so the overall cost of all of these appends is linear
--   not quadratic
demoAppendUsingDiffListConcept :: IO ()
demoAppendUsingDiffListConcept = do
  let f = ("a" ++) . ("b" ++)
  print $ f []

newtype DList a = DL {
  -- P/359
  -- unDL function is dtor, which removes the DL ctor. 
  -- when we go back and decide what we want to export from our 
  -- module, we will omit our data ctor and dtor so DList type
  -- will be completely opaque 
  unDL :: [a] -> [a]
}

-- P/359
-- unwrap and re-wrap the resulting function, so that it will
-- have the right type
append :: DList a -> DList a -> DList a
append xs ys = 
  DL (unDL xs . unDL ys)
  -- this works too
  -- append (DL xs) (DL ys) = DL (xs . ys)

fromList :: [a] -> DList a
fromList xs = 
  DL (xs ++)

toList :: DList a -> [a]
toList (DL xs) = 
  xs []

-- DList itself is not an instance of typeclass Show
demoDiffListCreation :: IO ()
demoDiffListCreation = do
  let dl1 = fromList [0..5]
      dl2 = fromList [100..105]
      dl3 = append dl1 dl2
  print $ toList dl3

-- provide more common list operations to make DList useful (as
-- regular lists)
empty :: DList a
empty = DL id

cons :: a -> DList a -> DList a
cons x (DL xs) =
  DL ((x:) . xs)

dfoldr :: (a -> b -> b) -> b -> DList a -> b
dfoldr f init (DL xs) =
  foldr f init (xs [])

demoDiffListCommonOperations :: IO ()
demoDiffListCommonOperations = do
  let dl1 = empty
      dl2 = (cons 100 dl1) `append` (fromList [0..5])
  print $ toList dl2
  print $ dfoldr (\lhs rhs -> lhs * 3 + rhs) 0 dl2

-- real world haskell P/360
-- although DList approach makes append() cheap... the head()
-- function requires that we convert the entire DList to a 
-- regular list

-- to support an equivalent of map we can make our DList type a 
-- functor
instance Functor DList where
  fmap f =
    dfoldr go empty
    -- initially xs is empty, x is the last element (outmost), 
    -- the last (++) evaluation, in the diff list
    where
      go x xs = cons (f x) xs

demoDiffListAsFunctor :: IO ()
demoDiffListAsFunctor = do
  let dl1 = fromList [11..15]
  print $ toList $ fmap (\e -> e * 11 + 1) dl1

-- real world haskell P/361
-- NOTE:
-- Since that tour was written, (<>) has been moved from Monoid to 
-- Semigroup, and all Monoid instances are required to also be 
-- Semigroup. mappend is just a synonym for (<>). So, you need two 
-- instances:
-- https://stackoverflow.com/questions/53622428/a-basic-monoid-definition-gives-no-instance-for-semigroup-mymonoid-arising-fr
instance Monoid (DList a) where
  mempty = empty

instance Semigroup (DList a)  where
  (<>) = append

demoDiffListAsMonoid :: IO ()
demoDiffListAsMonoid = do
  let dl1 = fromList [11..18]
      dl2 = mempty
  print $ toList (dl1 <> dl2)

main :: IO ()
main = do
  demoAppendUsingDiffListConcept
  demoDiffListCreation
  demoDiffListCommonOperations
  demoDiffListAsFunctor
  demoDiffListAsMonoid
