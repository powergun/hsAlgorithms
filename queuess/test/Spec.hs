import qualified FromScratchDequeSpec
import qualified PurelyFIFOSpec

main :: IO ()
main = do
  FromScratchDequeSpec.spec
  PurelyFIFOSpec.spec
