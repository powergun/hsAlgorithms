#!/usr/bin/env stack runghc

import Data.Map.Strict as M hiding (foldr)

a2z :: [(Int, String)]
a2z = zipWith (\i c -> (i, c:[])) [1..] ['a'..'z']

imap :: M.Map Int String
imap = M.fromList a2z

ifold :: M.Map Int String -> String
ifold = foldMap id

ifoldr :: M.Map Int String -> String 
ifoldr = foldr (\s t -> s ++ ", " ++ t) ""

itraverse :: M.Map Int String -> [Map Int String]
itraverse = traverse (\x -> [x ++ "-traversed"])

data Tree a = Empty
            | Tree (Tree a) a (Tree a)
            deriving (Show)

instance Foldable Tree where
  foldMap f Empty = mempty
  foldMap f (Tree left v right) = 
    (foldMap f left) `mappend` f v `mappend` (foldMap f right)
  foldr f x Empty = x
  foldr f x (Tree left v right) =
    -- right, self, left
    foldr f (f v (foldr f x right)) left 

instance Functor Tree where
  fmap f Empty = Empty
  fmap f (Tree left v right) =
    Tree (fmap f left) (f v) (fmap f right)
  
instance Traversable Tree where
  traverse f Empty = pure Empty
  traverse f (Tree left v right) = 
    Tree <$> (traverse f left) <*> (f v) <*> (traverse f right)

sampleTree :: Tree Int
sampleTree = 
  Tree l 10 r
  where
    l = Tree ll 8 lr
    ll = Tree Empty 7 Empty
    lr = Tree Empty 9 Empty
    r = Tree rl 12 rr
    rl = Tree Empty 11 Empty
    rr = Tree Empty 13 Empty

sampleSum :: Tree Int -> Int
sampleSum = foldr (+) 0

sampleTraverse :: Tree Int -> [Tree String]
sampleTraverse = traverse (\x -> [show x])

nodeToStr :: Show a => Tree a -> String
nodeToStr Empty = "."
nodeToStr (Tree l v r) = show v

main :: IO ()
main = do
  -- print imap
  -- print $ ifold imap
  -- print $ ifoldr imap
  -- print $ itraverse imap
  -- print $ sampleTree
  -- print $ sampleSum sampleTree
  -- print $ sampleTraverse sampleTree

  -- remember foldr starts with the right branch, then self,
  -- then left branch
  print $ foldr (\v vs -> vs ++ [v]) [] sampleTree
