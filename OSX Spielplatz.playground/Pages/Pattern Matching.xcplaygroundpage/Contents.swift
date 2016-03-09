//: [Previous](@previous)

//: Identifier Pattern
let value = 1
switch value {
case 1:
  print("Matched 1")
case 2:
  print("Matched 2")
default:
  print("Not matched")
}

let a = 10
if case 10 = a {
  print(a)
}
//: Wildcard Pattern
var x = 3
for _ in 1...3 {
  x *= 3
}
print(x)

if case _ = a {
  print(a) // Will *always* print the value of `a`
}
//: Tuple Pattern
switch (2, "Hello") {
case (1, "World"):
  print("Matched (1, World)")
case (2, "Hello"):
  print("Matched (2, Hello) ")
default:
  print("Didn't match.")
}

let myTuples = [(2, "Hello"), (3, "World"), (1, "Hello")]
for tuple in myTuples {
  switch tuple {
  case (_, "Hello"):
    print(tuple.0)
  default:
    print("Didn't match")
  }
}

for case (_, "Hello") in myTuples {
  print("Matched")
}

let myTuple = (50, 20)
if case (50, 20) = myTuple {
  print("\(myTuple.0), \(myTuple.1)")
}

let (month, days) : (String, Int) = ("Jan", 31)
//: Value-Binding Pattern
switch (40, 2) {
case (let x, let y):
  print("\(x) \(y)")
}

switch (40, 2) {
case let (x, y):
  print("\(x) \(y)")
}
switch (40, 2) {
case let (_, y):
  print(y)
}
let b = 10
if case let c = b {
  print(c)
}
//: Enumeration Case Pattern
enum Orientation {
  case FaceUp
  case FaceDown(Int)
}

let myEnum = Orientation.FaceUp
if case Orientation.FaceUp = myEnum {
  print("Face Up")
} else {
  print("Face Down")
}
let myOtherEnum = Orientation.FaceDown(10)
if case Orientation.FaceDown(10) = myOtherEnum {
  print("Face Down and associated value matched")
} else {
  print("Didn't match")
}
let otherEnum = Orientation.FaceDown(10)
if case let Orientation.FaceDown(x) = otherEnum {
  print(x)
}
// 10

if case var Orientation.FaceDown(x) = otherEnum {
  x += 1
  print(x)
}

enum Direction {
  case North(km: Int)
  case East(km: Int)
  case West(km: Int)
  case South(km: Int)
}

let directions : [Direction] = [
  .North(km:10),
  .South(km:3),
  .East(km:1),
  .West(km:6)]

for direction in directions {
  switch direction {
  case let .North(x):
    print("Head north for \(x)km")
  case let .East(x):
    print("Head east for \(x)km")
  case let .South(x):
    print("Head south for \(x)km")
  case let .West(x):
    print("Head west for \(x)km")
  }
}

enum thirdEnum {
  case firstValue(String)
  case secondValue
}
var myVar = thirdEnum.firstValue("Hello")

switch myVar {
case .firstValue(_):
  print("It matched.")
case .secondValue:
  break
}
//: Optional Pattern
let myOptional : String? = "Hello"
switch myOptional {
case let .Some(value):
  print(value)
case .None:
  break
}
if case "Hello"? = myOptional {
  print("Hello")
}
if case let welcome? = myOptional {
  print(welcome)
}

let optionalsArray : [Int?] = [1, 2, nil, 4, nil, 5]
for case let number? in optionalsArray {
  print(number)
}

//: Type Casting Pattern
import AppKit
let items = [NSString(string:"Hello"), NSControl(), NSTextField()]

for item in items {
  switch item {
  case is NSString:
    print("NSString")
  case is NSControl:
    print("UIControl")
  case is NSTextField:
    print("UIView")
  default:
    print("Unknown")
  }
}

let otherItems : [Any] = ["Hello", 10, (1, 2), NSButton(), 3.14159]
for item in otherItems {
  switch item {
  case 10 as Int:
    print("An integer with value 10")
  case let message as String:
    print("You're message is: \(message)")
  case let (firstValue, secondValue) as (Int, Int):
    print("A tuple containing two Int elements: (\(firstValue), \(secondValue))")
  default:
    print("Unknown")
  }
}
//: Expression Pattern
let percentage = 87
var letterGrade = ""
switch percentage {
case 0..<60:
  letterGrade = "E"
case 60..<70:
  letterGrade = "D"
case 70..<80:
  letterGrade = "C"
case 80..<90:
  letterGrade = "B"
case 90...100:
  letterGrade = "A"
default:
  letterGrade = "Unknown"
}

print("Grade: \(letterGrade)")
//: Where Clauses
let t = (40, 2)
switch t {
case let (a, 1...2):
  print("Matched a:\(a) b:???")
default:
  break;
}

switch t {
case let (a, b) where (1...2).contains(b):
  print("Matched a:\(a) b:\(b)")
default:
  break;
}
//: [Next](@next)
