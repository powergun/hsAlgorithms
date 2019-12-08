module Bool.BoolFunc (demo) where

import qualified Control.Monad as M
import qualified Data.Bool     as B

{-
bool :: a -> a -> Bool -> a

Case analysis for the Bool type. bool x y p evaluates to x when p
 is False, and evaluates to y when p is True.

This is equivalent to

if p then y else x;

that is, one can think of it as an if-then-else construct with its
 arguments reordered.
-}

-- use Bool.bool with pure values
demoPureBool :: IO ()
demoPureBool = do
  M.forM_ workload worker
  where
    workload = [1, 2, 3, 4]
    worker :: Int -> IO ()
    worker elem = do
      let elem' = elem * 2 + 1
      print $ B.bool "" "iddqd" $ elem' > 6

demo :: IO ()
demo = do
  demoPureBool
