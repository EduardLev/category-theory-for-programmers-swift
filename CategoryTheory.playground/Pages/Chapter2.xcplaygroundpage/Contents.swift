import Foundation

//: [ChapterOne](Chapter1)

//: Chapter Two

//: 1. Define a higher-order function (or a function object) memoize in your favorite language. This function takes a pure function f as an argument and returns a function that behaves almost exactly like f, except that it only calls the original function once for every argument, stores the result internally, and subsequently returns this stored result every time it’s called with the same argument. You can tell the memoized function from the original by watch- ing its performance. For instance, try to memoize a function that takes a long time to evaluate. You’ll have to wait for the result the first time you call it, but on subsequent calls, with the same argument, you should get the result immediately.

func memoize<A: Hashable, B>(_ f: @escaping (A) -> B) -> (A) -> B {
  var dictionary = Dictionary<A,B>()

  return { a in
    if let value = dictionary[a] {
      return value
    }

    let result = f(a)
    dictionary[a] = result
    return result
  }
}

//: 2. Try to memoize a function from your standard library that you normally use to produce random numbers. Does it work?

// This will not work because the same input will produce the same, and not random, output.

//: 3. Most random number generators can be initialized with a seed. Implement a function that takes a seed, calls the random number generator with that seed, and returns the result. Memoize that function. Does it work?

// This will work because the output given a seed will always be the same. This can be memoized.

//: 4. Which of these functions are pure? Try to memoize them and see what happens when you call them multiple times

// (a) Factorial Function
// (c) func f() -> Bool { print("Hello\n"); return true }
// (d) func f(_ x: Int) -> Int { static int y = 0; y += x; return y }

func factorial(_ input: Int) -> Int {
  return input == 0 ? 1 : input * factorial(input - 1)
}

func staticInt(_ x: Int) -> Int {
  struct Static {
    static var y = 0
  }
  Static.y += x
  return Static.y
}

staticInt(2)
staticInt(2)

factorial(4) // 24
factorial(4) // 24

memoize(factorial)(4) // 24
memoize(factorial)(4) // 24

// Cannot memoize (c) because the input type (Void) is not Hashable.

//: 5. How many different functions are there from Bool to Bool? Can you implement them all?

// maps T -> T and F -> F
func id_bool(_ x: Bool) -> Bool { return x }

// maps T -> F and F -> T
func inverse(_ x: Bool) -> Bool { return !x }

// maps T -> F and F -> F
func `false`(_: Bool) -> Bool { return false }

// maps T -> T and F -> T
func `true`(_: Bool) -> Bool { return true  }

//: 6. Draw a picture of a category whose only objects are the types Void, () (unit), and Bool, with arrows corresponding to all possible functions between these types. Label the arrows with the names of the functions.

// Void -> Unit = 1^0 = 1 (absurd)
// Bool -> Unit = 1^2 = 1 (unit)
// Unit -> Unit = 1^1 = 1 (id_unit)

// Void -> Void = 0^0 = 1 (id_void)
// Unit -> Void = 0^1 = 0 (no such function exists)
// Bool -> Void = 0^2 = 0 (no such function exists)

// Void -> Bool = 2^0 = 1 (absurd)
// Unit -> Bool = 2^1 = 2 (false, true)
// Bool -> Bool = 2^2 = 4 (id_bool, false, true, inverse)

//: [ChapterThree](Chapter3)
