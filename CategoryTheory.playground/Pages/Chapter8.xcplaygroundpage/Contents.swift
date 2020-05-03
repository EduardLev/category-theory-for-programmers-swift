//: [Chapter 7](@Chapter7)

import Foundation

//: 5. Define a Bifunctor. Implement bimap

struct Pair<A,B> {
  let first: A
  let second: B
}

func bimap<A,B,C,D>(_ f: @escaping ((A) -> C), _ g: @escaping ((B) -> D)) -> (Pair<A,B>) -> Pair<C,D> {
  return { abPair in
    Pair(first: f(abPair.first), second: g(abPair.second))
  }
}

let pair = Pair(first: 1, second: "Second")
print(bimap( { $0 }, { $0 })(pair))

//: [Next](@next)
