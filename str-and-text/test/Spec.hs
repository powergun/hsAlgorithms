
import qualified Concat.Append
import qualified FirstPrinciples.ByteStringZip
import qualified FirstPrinciples.Utf8
import qualified Partition.Split

main :: IO ()
main = do
  Concat.Append.demo
  Partition.Split.demo

  FirstPrinciples.ByteStringZip.demo
  FirstPrinciples.Utf8.demo
