//: [Chapter 9](@Chapter9)

//: 1. Define a natural transformation from the Maybe functor to the List functor. Prove the naturality condition for it.

// Maybe Functor
enum Maybe<T> {
  case nothing
  case just(T)
}

func fmap<A,B>(_ f: @escaping (A) -> B) -> (Maybe<A>) -> Maybe<B> {
  return {
    switch $0 {
      case .nothing: return .nothing
      case let .just(a): return .just(f(a))
    }
  }
}

// List Functor
enum List<T> {
  case empty
  indirect case list(T, List<T>)
}

func fmap<A,B>(_ f: @escaping (A) -> B) -> (List<A>) -> List<B> {
  return {
    switch $0 {
    case .empty: return .empty
    case let .list(head, tail): return .list(f(head), fmap(f)(tail))
    }
  }
}

func alpha<A>(optional: Maybe<A>) -> List<A> {
  switch optional {
    case .nothing: return .empty
    case let .just(a): return .list(a, .empty)
  }
}

// The naturality condition is that Gf . alpha = alpha . Ff

// Example: Gf . alpha:
let Gf: (List) -> List = fmap { $0 + 10 }
print(Gf(alpha(optional: .just(10)))) // list(20, empty)

// Example: alpha . Ff:
let Ff: (Maybe) -> Maybe = fmap { $0 + 10 }
print(alpha(optional: Ff(.just(10)))) // list(20, empty)



//: [Next](@next)
