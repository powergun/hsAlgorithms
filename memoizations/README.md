# Memoization

## High Perf Haskell P/40

simple example using lookup to solve the Fibonacci Sequence problem,
see `src/HighPerf/Fibonacci.hs`

> The time for lookups grows in size with larger numbers though, so a
> linked list is not a very appropriate data structure here.

P/42

> The formal difference between fib_mem and the others is that the
> fib_mem is something called a constant applicative form, or `CAF`
