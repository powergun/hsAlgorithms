#!/usr/bin/env stack runghc

-- let a = fromIntegral 123234324324324132424324234
-- :t a
-- a :: Num b => b

-- real world haskll P/186
demoPowerOf :: IO ()
demoPowerOf = do
  print (3.14 ** 3.14)
  print (3 ^ 3)
  -- print (4.312 ^ 3.12) compile error

demoAbs :: IO ()
demoAbs = do
  print (abs(1 - 12342))
  print (abs(- 0.00000))

main :: IO ()
main = do
  demoPowerOf
  demoAbs

