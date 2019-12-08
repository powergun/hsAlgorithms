module Maybe.FromMaybe
  ( demo
  )
where

import           Data.Maybe
import           Text.Read                      ( readMaybe )

demo :: IO ()
demo = do
  print $ fromMaybe "" (Just "Hello, World!")
  print $ fromMaybe "" Nothing

  -- Read an integer from a string using readMaybe. If we fail to parse an integer, we want to return 0 by default:
  print $ fromMaybe 0 (readMaybe "5")
  print $ fromMaybe 0 (readMaybe "")
