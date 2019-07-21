module Helpers
  ( verify
  , verify1
  , assert
  , forM_
  ) where

import           Control.Monad (forM_)

assert :: (Show a, Eq a) => a -> a -> IO ()
assert lhs rhs =
  case (lhs == rhs) of
    True  -> return ()
    False -> error $ "fail: " ++ show lhs ++ " != " ++ show rhs

verify :: ([Integer] -> Maybe Integer)
       -> [([Integer], Maybe Integer)]
       -> IO ()
verify f condidates = do
  forM_ condidates $ \condidate -> do
    let sequence = fst condidate
        expected = snd condidate
    assert expected (f sequence)

verify1 :: ([Integer] -> Int -> Maybe Integer)
        -> [([Integer], Int, Maybe Integer)]
        -> IO ()
verify1 f condidates = do
  forM_ condidates $ \condidate -> do
    let (sequence, index, expected) = condidate
    assert expected (f sequence index)
