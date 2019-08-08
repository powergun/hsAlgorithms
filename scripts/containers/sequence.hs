#!/usr/bin/env stack runghc

-- http://hackage.haskell.org/package/containers-0.6.2.1/docs/Data-Sequence.html

-- real world haskell P/362
-- Data.Sequence module defines a Seq container type that gives
-- good performance for a wider varity of operations
import qualified Data.Foldable as Foldable
import qualified Data.Sequence as Seq

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

demoSequenceConcat :: IO ()
demoSequenceConcat = do
  let one = Seq.singleton "1"
      two = Seq.fromList ["a", "b"]
  print (one Seq.>< two)

demoFromFunction :: IO ()
demoFromFunction = do
  let gen _ = "iddqd" -- ["iddqd","iddqd","iddqd","iddqd"]
  print (Seq.fromFunction 4 gen)

demoReplication :: IO ()
demoReplication = do
  print (Seq.replicate 4 "iddqd")
  print (Seq.replicateA 4 (map (+ 1)) [1, 2, 3])
  -- [[2,3,4],[2,3,4],[2,3,4],[2,3,4]]
  print (Seq.replicateA 4 (+ 1) 3) -- [4,4,4,4]
  print (Seq.cycleTaking 5 (Seq.fromList [1, 2, 3]))

main :: IO ()
main = do
  demoSeqCreation
  demoCreateListFromSeq
  demoSequenceConcat
  demoFromFunction
  demoReplication
