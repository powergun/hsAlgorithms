
import qualified Bool.BoolFunc
import qualified Either.EitherFunc
import qualified Maybe.MaybeFunc
import qualified Maybe.FromMaybe

main :: IO ()
main = do
  Bool.BoolFunc.demo
  Either.EitherFunc.demo
  Maybe.MaybeFunc.demo
  Maybe.FromMaybe.demo
