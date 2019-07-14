import System.IO
import qualified Data.Map.Strict as M
import System.Environment
import Control.Monad

hLines :: Handle -> IO [String]
hLines h = do
  isEOF <- hIsEOF h
  if isEOF then
    return []
  else
    (:) <$> hGetLine h <*> hLines h

main :: IO ()
main = do
  h <- openFile "ca_dev_bastion_syslog.txt" ReadMode
  lines <- hLines h
  print $ length lines
  hClose h