# Leftist Heaps

## in Haskell Cookbook

## in Purely Functional Data Structure P/27

(leftist heap is considered simple in both FP and imperative)

> Heaps are often implemented as heap-ordered trees, in which the element
> at each node is no larger than the elements at its children. Under this
> ordering, the minimum element in a tree is always at the root.

### Right Spine and Property

> Note that the elements along the right spine of a leftist heap (in
> fact, along any path through a heap-ordered tree) are stored in
> sorted order.
> The key insight behind leftist heaps is that two heaps can be merged
> by merging their right spines as you would merge two sorted lists, and
> then swapping the children of nodes along this path as necessary to
> restore the leftist property.
