{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module FromBinTree where

import           Data.Binary
import qualified Data.ByteString.Lazy as BL
import           Data.List            (sort)
import           GHC.Generics         (Generic)

data TreeT a = Leaf
             | Node (TreeT a) (TreeT a) a
             deriving (Generic, Show, Eq)

type Tree = TreeT Int

-- GHC will automatically fill out the instance
instance Binary Tree

-- reference: https://gist.github.com/Kedrigern/1239141/5ee8f5f45facdf4f48785fc92a78ad4104f16537
fromList :: [Int] -> Tree
fromList []     = Leaf
fromList (x:xs) =
  let root = Node Leaf Leaf x
  in fromList' root xs
  where
    fromList' n []     = n
    fromList' n (x:xs) = fromList' (insert n x) xs
    insert :: Tree -> Int -> Tree
    insert Leaf x = Node Leaf Leaf x
    insert n@(Node l r x') x
      | x == x' = n
      | x < x'  = Node (insert l x) r x'
      | x > x'  = Node l (insert r x) x'

preorder :: Tree -> [Int]
preorder Leaf         = []
preorder (Node l r v) = (preorder l) ++ [v] ++ (preorder r)

proofOfCorrectness :: IO ()
proofOfCorrectness = do
  let l = [3, 1, 4, 15, 9, 26, 53, 5, 8, 97]
      l' = preorder . fromList $ l
      l'' = sort l
  if l'' /= l'
  then error "failed"
  else return ()

demoEncoding :: IO ()
demoEncoding = do
  let l = [3, 1, 4, 15, 9, 26, 53, 5, 8, 97]
  (BL.writeFile "/var/tmp/bintree.txt") . encode . fromList $ l

demoDecoding :: IO ()
demoDecoding = do
  blob <- BL.readFile "/var/tmp/bintree.txt"  -- or: ./testdata/bintree.txt
  let tree :: Tree
      tree = decode blob
  print . preorder $ tree

demo :: IO ()
demo = do
  proofOfCorrectness
  demoEncoding
  demoDecoding
