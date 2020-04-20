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

/*
 f :: Maybe a -> Either () a
 f = if a == nil, return .left
     if a != nil, return .right(a)
 
 g :: Either () a -> Maybe a
 g = if .left, return nil (Nothing)
     if .right(a), return a (Just a)
 
 So, there is an invertible morphism between both that returns id in both cases.
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



//: 4: Prove the functor laws for the list functor. Assume that the laws are true for the
//:    tail part of the list you're applying it to.
