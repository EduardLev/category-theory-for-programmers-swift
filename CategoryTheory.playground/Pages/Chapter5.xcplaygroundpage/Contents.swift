//: [Chapter Four](@Chapter4)

import Foundation

//: 1. Show that the terminal object is unique up to isomorphism.

/*
 The terminal object is defined as an object in a category that has one, and only one, unique arrow (morphism) coming to it from all objects in the category.
 
 Assume that there are two terminal objects in a category and call them A and B. A has a unique morphism coming into it from all objects, including B. B has a unique morphism coming to it from all objects, including A. So we have the following:
 
           ----f---->
        A             B
           <---g-----
 
We can compose two new arrows from the above.

        f ∘ g = hB ( B --> B )
        g ∘ f = hA ( A --> A )
 
 There is already an arrow from A to A and from B to B - the corresponding identity arrows. From the definition of initial object, we know this identity arrow is unique! Therefore:
 
          hB = idB, hA = idA
 
        f ∘ g = idB ( B --> B )
        g ∘ f = idA ( A --> A )
 
 This is the definition of isomorphism, therefore
 the terminal objects are isomorphic because there is an invertible morphism between them.
 */

//: 2. What is the product of two objects in a poset? Hint: Use the universal construction.

/*
 A poset is a partially ordered set, e.g.
 if a <= b and b <= a, then a = b.
 
 In the universal construction, we have two elements a b, and their product c. c has an arrow, p, from c -> a and an arrow, q, from c -> b.
 
 Assume that we have another c' candidate for the product of a and b with projections p' and q'. c is the product if for any c', we can find a unique morphism m s.t. p' = p . m, and q' = q . m.
 
 Take a poset of cardinal numbers where arrows are <= relations. Take c and c' to be any two numbers smaller than both a and b. There will always be an arrow from c' to c if c' is <= c. Taking this to the extreme, we know that c will always have an arrow coming into it from any candidate c' if c is a tight upper bound on the minimum candidates a and b. This means c is the minimum of (a,b).
 
 Some numbers for example. Say a = 5 and b = 7. Their product is c = 5. c (5) <= 5, and c (5) <= 7. All numbers greater than 5 do not have an arrow going to c, while all numbers less than 5 have an arrow going to c, which rules them out for the product pattern, even though they are also <= 5 and <= 7.
 */

//: 3. What is a coproduct of two objects in a poset?

/*
 Similar to the above, we flip the arrows and and now a -> c and b -> c. The coproduct c is the object such that it has an outgoing arrow m to any other candidate for the coproduct, c'.
 
 Using <= as our poset relation, we know that a <= c and b <= c. Using similar logic as above, we know that c must be the lower bound on the maximum of a and b. Therefore c = max(a,b). Any other c' which has arrows from a and b and is therefore a candidate for the coproduct pattern will also have an arrow m (<=) from c, since c <= c' by our definition of c.
 */

//: 4. Implement the equivalent of Haskell Either as a generic type in your favorite language.

enum Either<A,B> {
  case left(A)
  case right(B)
}

//: 5. Show that Either is a "better" coproduct than int equipped with two injections:

/// p = int i(int n) { return n; }
/// q = int j(bool b) { return b ? 0: 1; }

// The above functions, in Swift:
// p' = func i(_ n: Int) -> Int { return n }
// q' = func j(_ b: Bool) -> Int { return b ? 0 : 1}

/*
 Either is a better coproduct if there exists a unique morphism `m` (Either -> Int) such that
          p' = m . p, q' = m . q
 
 We know m :: Either -> Int:
 func m(_ either: Either) -> Int {
   switch either:
     case let left(int): return int
     case let right(bool): return b ? 0 : 1
 }
 
In this case, A = Int and B = Bool.
 So p' :: Int -> Int and
    q' :: Bool -> Int.
 
 The injections for Either are:
 p :: Int -> Either { return .left(int) }
 q :: Bool -> Either { return .right(bool) }
 
 m . p = Int -> Either -> Int
 First we create a .left(int) from the original int, then m takes Either and extracts the same Int. This is equivalent to p'.
 
 m . q = Bool -> Either -> Bool
 First we create a .left(bool) from the original bool, then m takes Either and extracts 0 if b is true, and 1 if b is false. This is the same as the original function q'.
 
 Therefore we have satisfied the condition to prove that Either is "better" than Int as a candidate for the coproduct of Int and Bool.
 */

//: 6. Continuing the previous problem. How would you argue that Int with the two injections i and j cannot be "better" than Either?

/*
 Int's injection from Int -> Int maintains all information about the input, so that seems kosher.
 
 Int's injection from Bool -> Int is way too large. Bool only needs two values to hold its "truth" (0 or 1) so using Int, which has a much larger set of values than Bool, seems too much.
 
 In terms of morphisms, for Int to be better than Either, there must exist a unique morphism Int -> Either that factorizes p' and q'. In the case of Int, p . m = p' is true. The original p function returns the original Int, and the m function from Int -> Either wraps it in a .left. This is equivalent to p' from Int -> Either.
 
 The morphism m from Int to Either then has to take 0 and map it to "true" and 1 and map it to "false". But the morphism m cannot take the inputs 0 and 1 and map them to a .right case (which is necessary to factorize q'), because it already maps them to a .left case.
 
 Therefore you can see that Int as a product maps some inputs from Int and Bool to the same point in Int. Once that is done, it's impossible to know which type that point "came from" and we are collapsing information.
 */

//: 7. Still continuing: What about these injections:

// int i(int n) { if n < 0 return n; }
//                return n + 2; }
// int j(bool b) { return b ? 0 : 1 }

/*
 The morphism j is mapping 'true' to 0 and 'false' to 1 (in the domain of Int's).
 
 What about the morphism i? Does it map any of its inputs to the outputs 0 or 1?.
 i(0) = 2
 i(1) = 3
 i(-1) = -1
 ...
 So we can see that 0 and 1 are not part of the codomain of the function i.
 Therefore, continuing from the answer in part 6, we will be able to come up with a morphism from Int -> Either that preserves information, since we know that 0 and 1 must have from the Bool.
 
 However, since we can now go from Int to Either (by mapping 0 and 1 to T and F, and all other ints to .left) then we can also go from Either to Int by doing the opposite. Combined with the identity functions, this means Int and Either are isomorphic, so one is not better than the other.
 */

//: 8. Come up with an inferior candidate for a coproduct of Int and Bool that acnnot be better than Either because it allows multiple acceptable morphisms from it to Either.

/*
 (Int, Int, Bool) because you can map the first Int to Left or the second Int to Left.
 (Int, Bool, Bool) because you can map the first Bool to Right or the second Bool to Right.
 */

//: [Chapter Six](@Chapter6)
