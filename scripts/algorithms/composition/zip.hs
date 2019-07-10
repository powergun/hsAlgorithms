#!/usr/bin/env stack runghc

-- see containers/grid for application

-- zipOverGridWith f grid1 grid2 = (zipWith (zipWith f)) grid1 grid2

-- given a function F, two grids: grid1 grid2
-- create a new grid (that fits in the smallest grid of these two)
-- where each cell is constructed by calling F using the the
-- cell data from each grid, i.e.
-- cellNew = F cell1 cell2
zipOverGridWith = zipWith . zipWith
