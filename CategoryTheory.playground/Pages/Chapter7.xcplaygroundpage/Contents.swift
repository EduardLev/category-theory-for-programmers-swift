//: [Chapter Six](@Chapter6)

import Foundation

//: 1. Can we turn the Maybe type constructor into a functor by defining:
//:    fmap _ _ = Nothing
//:    which ignores both of its arguments?

/*
 This is a functor if fmap preserves identity and composition.
 
 Clearly identity preservation does not hold for this implementation of fmap.
 id_maybe turns a Maybe A into the same Maybe A.
 This id always turns Maybe A into Nothing.
 This is OK in the case of Nothing, but not in the case of Just x.
 */

//: 2: Prove functor laws for the reader functor:
/*
 1) Identity Preservation, fmap id_a = id_reader
 
 fmap :: a -> b -> (r -> a) -> (r -> b) = (.)

 fmap id_a (r -> a) = (.) id_a (r -> a) = id_a . (r -> a) = (r -> a) = id_reader (r -> a)
 therefore fmap id_a = id_reader
 
 2) Composition Preservation fmap (g . f) = fmap g . fmap f
 
 fmap (g . f) h = (.) (g . f) h = (g . f) . h = g . (f . h) = (.) g (f . h) = fmap g (f . h) = fmap g ((.) f h) = fmap g (fmap f h)
 = (fmap g . fmap f) h
 therefore fmap (g . f) = fmap g . fmap f
 */

//: 3: Implement the reader functor in your second favorite language (Swift):

// Reader is a wrapper type for R -> A
struct Reader<R, A> {
  let function: (R) -> A
}

func fmap<R, A, B>(_ f: @escaping (A) -> B) -> (Reader<R, A>) -> Reader<R, B> {
  return { initialReader in
    Reader(function: initialReader.function∘f)
  }
}

//: 4: Prove the functor laws for the list functor. Assume that the laws are true for the
//:    tail part of the list you're applying it to.

enum List<A> {
  case empty
  indirect case list(A, List)
}

func fmap<A, B>(_ f: @escaping (A) -> B) -> ((List<A>) -> List<B>) {
  return { listA in
    switch listA {
    case .empty:
      return .empty
    case let .list(head, tail):
      return .list(f(head), fmap(f)(tail))
    }
  }
}

// 1) Identity Preservation, fmap id_a = id_listA
// fmap id_a empty = fmap empty = empty = id empty
// fmap id_a list = list(id(a), fmap(id)(tail) = list(a, fmap(tail) = list(a, tail) = id list(a, tail)

// 2) Composition Preservation fmap (g . f) = fmap g . fmap f
// fmap (g . f) empty = empty = fmap g empty = fmap g (fmap f empty) = fmap g . fmap f (empty)
// fmap (g . f) list = list(g.f(head), fmap(g.f)(tail)) = list(g.f(head), (fmap g . fmap f (tail))
//  list(g( f (head), (fmap g . fmap f(tail)) = fmap g list(f(head), fmap f(tail))
//  = fmap g . fmap f (list(head), tail)

//: [Chapter Seven](@Chapter7)
