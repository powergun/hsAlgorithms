module Main (main) where

import           Control.Monad
import qualified Data.Text         as T
import qualified Data.Text.IO      as TIO
import qualified Data.Text.Lazy    as TL
import qualified Data.Text.Lazy.IO as TLIO
import qualified System.IO         as SIO

sut = "/etc/passwd" :: String

dictWords :: IO String
dictWords = SIO.readFile sut

dictWordsT :: IO T.Text
dictWordsT = TIO.readFile sut

dictWordsTL :: IO TL.Text
dictWordsTL = TLIO.readFile sut

main :: IO ()
main = do
  replicateM_ 10 (dictWords >>= putStr)
  replicateM_ 10 (dictWordsT >>= TIO.putStr)
  replicateM_ 10 (dictWordsTL >>= TLIO.putStr)
  putStrLn ""
