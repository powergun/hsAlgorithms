#!/usr/bin/env stack runghc

-- TODO: read into Data.Sequence container

-- real world haskell P/362
-- Data.Sequence module defines a Seq container type that gives 
-- good performance for a wider varity of operations
import qualified Data.Sequence as Seq
import qualified Data.Foldable as Foldable

demoSeqCreation :: IO ()
demoSeqCreation = do
  print "//// demo Seq creation and constant-time/logn ops"
  let e = Seq.empty
      one = Seq.singleton 1
      afew = Seq.fromList [0..4]
      -- P/363
      -- both adding on the left and adding on the right are 
      -- constant-time operations
      prepended = -1 Seq.<| one
      appended = one Seq.|> 33
      -- appending two Seqs is also cheap, occurring in time
      -- proportional to the logarithm of whichever is shorter
      -- Logn(min(p, q))
      appendSeq = afew Seq.>< appended
  print one
  print afew
  print prepended
  print appended
  print appendSeq

demoCreateListFromSeq :: IO ()
demoCreateListFromSeq = do
  -- P/363
  -- this module defines a typeclass, Foldable, which Seq implements
  print $ Foldable.toList $ Seq.fromList [-4..3]
  -- if we want to fold over a Seq, we use the fold functions from
  -- Data.Foldable module
  print $ Foldable.foldl' (\r n -> n * 3 + r) 0 (Seq.fromList [-4..6])

-- Lists are simpler and have less overhead, and so quite often 
-- they are good enough for the task at hand
-- they are also well suited to a lazy setting, whereas Seq
-- does not well

main :: IO ()
main = do
  demoSeqCreation
  demoCreateListFromSeq
