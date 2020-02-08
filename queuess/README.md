# Queue

## Discover Double-Ended Queue (Deque), First Principles

P/1152, mentioning that, this data structure comes from
From Okasaki's Purely Functional Data Structures

NOTE: I made a mistake in the impl `FromScratchDeque.hs` - this is
exactly the bad example First Principles wants to demonstrate:
excessively using reverse to achieve the push-pop order;

I fixed this in `CorrectDeque.hs` and created a benchmark driver

`stack bench` - the good impl (94.14 μs) is 100x faster than the
navie impl (153.1 ms)

## Purely Functional Data Structure, FIFO and Amortization P/53

This chapter focuses on amortization and cost analysis; the Queue
example (FIFO) is revisited as a case study.

see `src/PurelyFDS/FIFO.hs`; note the structure is based on two
lists: `f`, `r`

P/52

> Elements are added to r and removed from f, so they must somehow
> migrate from one list to the other. This migration is accomplished
> by reversing r and installing the result as the new f whenever f
> would otherwise become empty, simultaneously setting the new r to [].

the invariant:

> The goal is to maintain the invariant that f is empty only if r is
> also empty (i.e., the entire queue is empty).

### amortized tail() and snoc(), O(1), using banker's method

P/53

> Using the banker's method, we maintain a credit invariant that every
> element in the rear list is associated with a single credit.
