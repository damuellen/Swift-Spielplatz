//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

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
let d = Double("")


let x = [1,2,3,4,5,6,7,8]
let y = [5,6,7,8,9,10,11,12]
let z = [1,2,3,4,5,6,7,8,9]

zip3(x, y, z)  .forEach { (a, b, c) in
  let z = a + b + c
}


public protocol Arithmetic {
  func +(lhs: Self, rhs: Self) -> Self
  func -(lhs: Self, rhs: Self) -> Self
  func *(lhs: Self, rhs: Self) -> Self
  func /(lhs: Self, rhs: Self) -> Self
}

extension Float : Arithmetic {}
extension Double : Arithmetic {}

public extension Arithmetic {
  
  public func lerp(min min: Self, max: Self) -> Self {
    return min + (self * (max - min))
  }
  public func ilerp(min min: Self, max: Self) -> Self {
    return (self - min) / (max - min)
  }
}

public func ilerp<T: Arithmetic>(value: T, min: T, max: T) -> T {
  return value.ilerp(min: min, max: max)
}

public protocol Clampable {
  func clamp(min min: Self, max: Self) -> Self
}
/**
 Clamps the value between an lower and upper bound.
 - parameter value: The input value.
 - parameter min: The lower bound. Should be less than *max*.
 - parameter max: The upper bound. Should be greater than *min*.
 - returns: Returns *min* if *value* is less than min, or *max* if *value* is greater than *max*. Else, returns *value*. If *min* is greater than *max*, it just returns *value*.
 */
public func clamp<T: Clampable>(value: T, min: T, max: T) -> T {
  return value.clamp(min: min, max: max)
}

extension Double: Clampable {
  public func clamp(min min: Double, max: Double) -> Double {
    if min < max { return Swift.min(Swift.max(self, min), max) } else { return self }
  }
}

extension Float: Clampable {
  public func clamp(min min: Float, max: Float) -> Float {
    if min < max { return Swift.min(Swift.max(self, min), max) } else { return self }
  }
}
//: [Next](@next)
