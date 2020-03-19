import UIKit

//: Chapter One
//: 1. Implement, as best as you can, the identity function in your favorite language (or the second favorite, if your favorite language happens to be Haskell).

func id<A>(_ a: A) -> A {
  return a
}

//: 2. Implement the composition function in your favorite language. It takes two functions as arguments and returns a function that is their composition.
infix operator ∘: ForwardComposition

precedencegroup ForwardComposition {
  associativity: left
}

func ∘<A,B,C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
  return { a in
    g(f(a))
  }
}

//: 3. Write a program that tries to test that your composition function respects identity.

func square(_ int: Int) -> Int {
  return int*int
}

(id∘square)(5) == (square∘id)(5) // true
(id∘square)(5) == square(5) // true
// However, that only tests the input `5`.

//: 4. Is the world-wide web a category in any sense? Are links morphisms?

// Maybe?
// Webpages can be thought of as "objects" and "links" as arrows from one object to another.
// To be a category, the composition of links must be associative, and there must be an identity arrow.
// The identity arrow can probably be the URL of the current webpage.
// Starting at Webpage A, and going along the identity arrow (clicking the URL) will take you to A
// That is, if you consider the new rendered content the same "object" as orginal Webpage A.
//
// But is composition is associative?
// We need the following property: a ∘ b ∘ c = a ∘ (b ∘ c) = (a ∘ b) ∘ c, where a b and c are URLs.
// b∘c is the URL of C. What does a ∘ (URL C) mean?


//: 5. Is Facebook a category, with people as objects and friendships as morphisms?

// Maybe?
// The morphism (Friendshp A/B) ∘ (Friendship B/C) implies a morphism (Friendship A/C)
// Sure, you can get from A to C by composing the two morphisms, but that new arrow is not a
// friendship itself. Does this count?

//: 6. When is a directed graph a category?

// When each node has an identity arrow, and possible compositions are drawn.

//: [Chapter Two](Chapter2)
