#!/usr/bin/env stack runghc

-- haskell cookbook L1747

data Tree a = Leaf a
            | Node (Tree a) a (Tree a)
            deriving (Show)

treeSUT :: Tree String
treeSUT = 
  Node 
    (Node 
      (Leaf "/dv/man") 
      "/dv"
      (Node 
        (Leaf "/dv/usr/d1") 
        "/dv/usr" 
        (Leaf "/dv/usr/c1"))) 
    "/"
    (Node 
      (Node 
        (Leaf "/pd/dat/rig") 
        "/pd/dat" 
        (Leaf "/pd/dat/mdl")) 
      "/pd"
      (Leaf "/pd/man"))

-- recap on inorder, preorder, postorder applications
-- see 
-- https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/

-- (depth-first)
-- In case of binary search trees (BST), Inorder traversal gives 
-- nodes in non-decreasing order. To get nodes of BST in 
-- non-increasing order, a variation of Inorder traversal where 
-- Inorder traversal s reversed can be used.

-- Preorder traversal is used to create a copy of the tree. Preorder 
-- traversal is also used to get prefix expression on of an 
-- expression tree

-- Postorder traversal is used to delete the tree.
-- Postorder traversal is also useful to get the postfix expression 
-- of an expression tree.

inorder :: (Show a) => Tree a -> [a]
inorder (Leaf x) = [x]
inorder (Node l x r) = (inorder l) ++ [x] ++ (inorder r)

preorder :: (Show a) => Tree a -> [a]
preorder (Leaf x) = [x]
preorder (Node l x r) = [x] ++ (preorder l) ++ (preorder r)

postorder :: (Show a) => Tree a -> [a]
postorder (Leaf x) = [x]
postorder (Node l x r) = (postorder l) ++ (postorder r) ++ [x]

-- haskell cookbook L1768
bfirst :: (Show a) => Tree a -> [a]
bfirst (Leaf x) = [x]
bfirst tree = bf [tree] [] []
  where
    -- current level, next level, elements
    bf [] [] xs = reverse xs -- stop case
    -- go to the next level
    bf [] q  xs = bf (reverse q) [] xs -- q is next level
    -- current level
    bf ((Leaf x):ts)     q xs = bf ts q       (x:xs) -- xs is reversed
    -- "appending" children to the next level
    -- note that "appending" is achieved using reverse()
    bf ((Node l x r):ts) q xs = bf ts (l:r:q) (x:xs) -- q is reversed

main :: IO ()
main = do
  print $ inorder treeSUT
  print $ preorder treeSUT
  print $ postorder treeSUT
  print $ bfirst treeSUT