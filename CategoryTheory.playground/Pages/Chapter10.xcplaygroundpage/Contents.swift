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

// Natural Transformation
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

//: 2 Define at least two different natural tarnsformations between Reader () and the list functor. How many different lists of () are there?

/*
 The natural transformations have to have the type of Reader () T -> List<T>.
 */

struct Reader<T> {
  let value: () -> T
}

func natOne<T>(_ reader: Reader<T>) -> List<T> {
  return .empty
}

func natTwo<T>(_ reader: Reader<T>) -> List<T> {
  return .list(reader.value(), .empty)
}

/*
 There are infinite different lists of (), because we can insert an arbitrary amount of () values into this returned list.
 */

//: 3 Continue the previous exercise with Reader Bool and Maybe.

/*
 The natural transformatons have to have the type of Reader Bool T -> Maybe<T>
 */

func natThree<T>(_ reader: (Bool) -> T) -> Maybe<T> {
  return .nothing
}

func natFour<T>(_ reader: (Bool) -> T) -> Maybe<T> {
  return .just(reader(true))
}

func natFive<T>(_ reader: (Bool) -> T) -> Maybe<T> {
  return .just(reader(false))
}

/*
 There are three possible natural transformations from Reader Bool T -> Maybe<T>
 */

//: 4 Show that the horizontal composition of natural transformation satisfies the naturality condition (hint: use components). It's a good exercise in diagram chasing.



//: [Next](@next)
