import qualified TestFromBinTree
import qualified TestFromByteString

main :: IO ()
main = do
  TestFromByteString.demo
  TestFromBinTree.demo
