module Uuid (demo) where

import           Control.Monad (forM_)
import           Data.Text     (Text)
import qualified Data.Text     as T
import qualified Data.UUID     as UUID
import qualified Data.UUID.V4  as UUIDv4

textUuid :: IO Text
textUuid =
  fmap (T.pack . UUID.toString) UUIDv4.nextRandom

demo :: IO ()
demo = do
  forM_ [1..10] (\_ -> print =<< textUuid)
