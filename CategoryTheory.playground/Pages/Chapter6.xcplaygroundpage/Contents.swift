//: [Chapter Five](@Chapter5)

import Foundation

//: 1. Show the isomorphism between Maybe a and Either () a.

/*
 f :: Maybe a -> Either () a
 f = if a == nil, return .left
     if a != nil, return .right(a)
 
 g :: Either () a -> Maybe a
 g = if .left, return nil (Nothing)
     if .right(a), return a (Just a)
 
 So, there is an invertible morphism between both that returns id in either case.
 */

//: 2: Here's a sum type defined in Haskell:
/*
 data Shape = Circle Float | Rect Float Float
 */
//: When we want to define a function like area that acts on a Shape, we do it by pattern matching on the two constructers:
/*
 area :: Shape -> Float
 area (Circle r) = pi * r * r
 area (Rect d h) = d * h
 */
//: Im

enum Either<A,B> {
  case left(A)
  case right(B)
}

func m(_ int: Int) -> Either<Int,Bool> {
  if int == 0 {
    return .right(true)
  } else if int == 1 {
    return .right(false)
  } else if int < 0 {
    return .left(int)
  } else if int > 1 {
    return .left(int - 2)
  }
}

func mPrime(_ either: Either<Int, Bool>) -> Int {
  switch either {
  case let .left(int):
    return int
  case let .right(bool):
     return bool ? 0 : 1
  }
}






//: [Next](@next)
