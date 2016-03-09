//: [Previous](@previous)
import Darwin

func tenth(x: Int) -> Double {
  return Double(x) / 10
}

for i in (1...20).map(tenth) {
  i
}

func inverseSquare(x: Int ) -> Double {
  return pow(Double(x), -2)
}

for i in (0...20).map(inverseSquare) {
  i
}


let count = 360 / 10
let π = Double(M_PI)
let theta = π * 2 / Double(count)

func sinWave(x: Int) -> Double {
  return sin(Double(x) * theta)
}

for i in (1...count).map(sinWave) {
  i
}

let max = 8.0 * π
let damp =  0.stride(through: max, by: π / 8)
damp.map {1 - cos($0) * exp(-(2.0 * $0 / max))}

func sumRecursively(numbers: [Int], _ total: Int = 0) -> Int {
  if let head = numbers.first {
    let tail = Array(numbers.dropFirst())
    return sumRecursively(tail, head + total)
  } else {
    return total
  }
}

let myNumbers = [1,2,3,4,5]
sumRecursively(myNumbers)

// Given three sequences, return a sequence of 3-tuples
public func zip3<A: SequenceType, B: SequenceType, C: SequenceType>(a: A, _ b: B, _ c: C) -> Zip3Sequence<A, B, C> {
  return Zip3Sequence(a, b, c)
}
// Sequence of tuples created from values from three other sequences
public struct Zip3Sequence<A: SequenceType, B: SequenceType, C: SequenceType>: SequenceType {
  private var a: A, b: B , c: C
  public init (_ a: A, _ b: B, _ c: C) { self.a = a; self.b = b; self.c = c }
  public func generate() -> Zip3Generator<A.Generator, B.Generator, C.Generator> {
    return Zip3Generator(a.generate(), b.generate(), c.generate())
  }
}
// Generator that creates tuples of values from three other generators
public struct Zip3Generator<A: GeneratorType, B: GeneratorType, C: GeneratorType>: GeneratorType {
  private var a: A, b: B, c: C
  public init(_ a: A, _ b: B, _ c: C) { self.a = a; self.b = b; self.c = c }
  mutating public func next() -> (A.Element, B.Element, C.Element)? {
    switch (a.next(), b.next(), c.next()) {
    case let (aValue?, bValue?, cValue?): return (aValue, bValue, cValue)
    default: return nil
    }
  }
}

//: [Next](@next)
