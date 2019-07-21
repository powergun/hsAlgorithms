module Helpers
  ( verify
  , forM_
  ) where

import           Control.Monad (forM_)

verify :: ([Integer] -> Maybe Integer) -> [([Integer], Maybe Integer)] -> IO ()
verify f condidates = do
  forM_ condidates $ \condidate -> do
    let input = fst condidate
        expected = snd condidate
    assert expected (f input)
  where
    assert lhs rhs =
      case (lhs == rhs) of
        True  -> return ()
        False -> error $ "fail: " ++ show lhs ++ " != " ++ show rhs
