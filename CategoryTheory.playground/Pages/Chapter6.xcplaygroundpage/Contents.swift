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
 
 So, there is an invertible morphism between both that returns id in both cases.
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
//: Implement Shape in C++ or Java as an interface and create two classes: Circle and Rect. Implement area as a virtual function.

enum Shape {
  case circle(radius: Double)
  case rectangle(depth: Double, height: Double)
}

func area(shape: Shape) -> Double {
  switch shape {
  case let .circle(radius):
    return Double.pi * radius * radius
  case let .rectangle(depth, height):
    return depth * height
  }
}

//: 3. Continuing with the previous example: We can easily add a new function circ that calculates the cirumference of a Shape. We can do it without touching the definition of Shape:

//circ :: Shape -> Float
//circ (Circle r) = 2.0 * pi * r
//circ (Rect d h) = 2.0 * (d + h)

func circ(_ shape: Shape) -> Double {
  switch shape {
  case let .circle(radius):
    return 2.0 * Double.pi * radius
  case let .rectangle(depth, height):
    return 2.0 * (depth + height)
  }
}

//: 4. Continuing further: Add a new shape, Square, to Shape and make all the necessary updates. What code did you have to touch in Haskell vs C++ or Java? (Even if you're not a haskell programmer, the modifications should be pretty obvious).

// Need another initializer for `data Shape`, and to add implementations to each function.
// In Swift, need another enum case and to add one more `case let`. Very similar to Haskell.

//: 5. Show that a + a = 2 x a holds for types (up to isomorphism). Remember that 2 corresponds to Bool, according to our translation table.

/*
 a + a = Either<A,A>
 2a = (2,A) = (Bool, A)
 
 These types can be shown to be isomorphic if we can find functions like the following:
 
 f :: Either<A,A> -> (Bool, A)
 g :: (Bool, A) -> Either<A,A>
 f . g = id(Bool, A)
 g . f = id(Either<A,A>)
 
 func f(_ sum: Either<A,A>) -> (Bool, A) {
   switch sum {
    case let .left(a):
      return (true, a)
    case let .right(a):
      return (false, a)
   }
 }
 
 func g(_ product: (Bool, A)) -> Either<A,A> {
   return product.0 ? .left(a) : .right(a)
 }
 
 f . g --> maps (true, a) to .left(a) to (true, a) = id
 g . f --> maps .right(a) to (false, a) to .right(a) = id
 */

//: [Chapter Seven](@Chapter7)
