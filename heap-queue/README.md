# Leftist Heaps

## in Haskell Cookbook

## in Purely Functional Data Structure P/27

(leftist heap is considered simple in both FP and imperative)

> Heaps are often implemented as heap-ordered trees, in which the element
> at each node is no larger than the elements at its children. Under this
> ordering, the minimum element in a tree is always at the root.

### Right Spine and Property

rank

> leftist property: the **rank** of any **left child** is at least as large
> as the rank of its right sibling.
> **The rank of a node is defined to be the length of its right spine** > **i.e., the rightmost path from the node in question to an empty node**

P/28 Exercise 3.1 Proof (see: <https://github.com/rst76/pfds/blob/master/ch03/ex.3.1.md>)

```text
       o
     o   o
    o o o o <- can not delete any of these
 .............
```

given the rank is D, size is N, the minimal size N = 2 ^ D - 1
because it is not possible to remove any leaf nodes without violating
the leftist law

what can this property do

> Note that the elements along the right spine of a leftist heap (in
> fact, along any path through a heap-ordered tree) are stored in
> sorted order.
> The key insight behind leftist heaps is that two heaps can be merged
> by merging their right spines as you would merge two sorted lists, and
> then swapping the children of nodes along this path as necessary to
> **restore the leftist property**.
