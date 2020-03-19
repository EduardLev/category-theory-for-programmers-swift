//: [ChapterTwo](ChapterTwo)

import Foundation

//: 1. Generate a free category from:
//: (a) A graph with one node and no edges
//: (b) A graph with one node and one (directed) edge
//: (c) A graph with two nodes and a single arrow between them
//: (d) A graph with a single node and 26 arrows marked with the letters of the alphabet: a, b, c ... z.

// (a) Draw the id arrow
// (b) Draw the id arrow, draw the composition a . a
// (c) Draw the id_a and id_b arrows.
// (d) Draw the id arrow, and all composition arrows a . b, a . c, etc.

//: 2. What kind of order is this?
//: (a) A set of sets with the inclusion relation: 𝐴 is included in 𝐵 if every element of 𝐴 is also an element of 𝐵.
//: (b) C++types with the following subtyping relation: T1 is a sub- type of T2 if a pointer to T1 can be passed to a function that expects a pointer to T2 without triggering a compilation error.

// (a) if every element of A is included in B, then A is included in B.
//     if every element of B is included in A, then B is included in A.
//     if both are true, then A = B. This is a partial order.
//     Other sets may be disjoint, would not consider this inclusion relation.
//     Therefore it is not total.
// (b) If T1 can be passed to T3 (a super type of T2) then this is a preorder at least.
//     If T1 -> T2 and T2 -> T1, then T1 = T2 holds as well. This is a partial order.

//: 3. Considering thatBool is a set of two values True and False,show that it forms two (set-theoretical) monoids with respect to, re- spectively, operator && (AND) and || (OR).

// To form a monoid, we need a set of values (True and False), a binary operator (&&, ||),
// and an identity element.
// The identity element for && is True, because T && T -> T, F && T -> F
// The && binary relation is associative because (a && b) && c = a && (b && c) = a && b && c

// The identity element for || is False, because T || F -> T, F || F -> F
// The || binary relation is associative because (a || b) || c = a || (b || c) = a || b || c

//: 4. Represent the Bool monoid with the AND operator as a category: List the morphisms and their rules of composition.

// To convert Set Monoid to category: Build morphisms as binary operator + value from set.
// mappend (m) -> (m) -> (m) given an (m) will return (m) -> (m) morphism.
// Morphism 1) && True
// Morphism 2) && False

//: 5. Represent addition modulo 3 as a monoid category.

// The binary operation is addition modulo 3
// Elements of the addition modulo 3 set are 0, 1, 2.
// Morphisms are +0 mod 3, +1 mod 3, +2 mod 3

//: [ChapterFour](ChapterFour)
