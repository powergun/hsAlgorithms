#!/usr/bin/env stack runghc

import Data.List

data Cell = Cell (Int, Int) Char
    deriving (Eq, Ord, Show)

grid = [ "__C________R___"
       , "__SI________U__"
       , "__HASKELL____B_"
       , "__A__A_____S__Y"
       , "__R___B___C____"
       , "__PHP____H_____"
       , "____S_LREP_____"
       , "____I__M_Y__L__"
       , "____L_E__T_O___"
       , "_________HB____"
       , "_________O_____"
       , "________CN_____"
       ]

-- variant of outputGrid(), for arbitrary show-able structures
outputGrid :: Show a => [a] -> IO ()
outputGrid = putStrLn . unlines . map show

div2 x = x `mod` 2 == 0

genCoords =
    let cols = repeat [0..]
        rows = map repeat [0..]
    in zipWith zip rows cols
coords = genCoords
-- the inner zipWith (,) can be simplified as zip
-- the inner zipWith combine one row or coords with one row of
-- characters
gg = (zipWith (zipWith (,))) coords grid

-- replacing the inner zipWith (,) to zipWith Cell, it is able
-- to reproduce the Cell data directly
gridWithCoords = (zipWith (zipWith Cell)) coords grid

main :: IO ()
main = do
    outputGrid gridWithCoords
