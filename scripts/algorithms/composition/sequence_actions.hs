#!/usr/bin/env stack runghc

-- programming haskell L550
-- L573
-- for monadic type m, of which IO is just one example, seqn maps a list 
-- of actions of type m a into a single action that returns a list of 
-- values of type a 
seqn [] = return []
seqn (act:acts) = do
    x <- act
    xs <- seqn acts
    return (x:xs)

-- test it use stack ghci
-- :load sequence_actions.hs
-- seqn [getChar, getChar]
