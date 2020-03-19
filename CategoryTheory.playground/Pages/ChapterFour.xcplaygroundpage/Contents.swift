import Foundation

//: [ChapterThree](ChapterThree)

func safe_root(_ x: Double) -> Double? {
  return x < 0 ? nil : sqrt(x)
}

//: 1. Construct the Kleisli category for partial functions (define composition and identity).

// In a Kleisli category, the objects are types (A, B, etc.)
// and the morphisms are effectful functions.
// To finish off the category definition, we need to define
// associative composition, and the identity morphism.

precedencegroup EffectfulCompose {
    associativity: left
}

infix operator >=>: EffectfulCompose
func >=><A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C?) -> (A) -> C? {
    return { a in
        guard let b = f(a) else { return nil }
        guard let c = g(b) else { return nil }
        return c
    }
}
func id<A>(x: A) -> A? {
    return Optional(x)
}

//: 2. Implement the embellished function safe_reciprocal that returns a valid reciprocal of its argument, if its different from zero.

func safe_reciprocal(_ x: Double) -> Double? {
  return x == 0 ? nil : 1/x
}

//: 3. Compose the functions safe_root and safe_reciprocal to implement safe_root_reciprocal that calculates sqrt(1/x) whenever possible.

let safe_root_reciprocal = safe_root >=> safe_reciprocal
safe_root_reciprocal(9) // 0.333...

//: [Next](@next)
