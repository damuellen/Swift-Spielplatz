//: [Previous](@previous)

var str = ""

protocol talkProtocol {
  /// Properties
  var name: String { get }
  /// Methods
  func sayName()
}

protocol talkObserver {
  func record(name: String, some: Any)
}
func ==(lhs: talkProtocol, rhs: talkProtocol) -> Bool {
  return lhs.isEqual(rhs)
}

func ==(lhs: person, rhs: person) -> Bool {
  return lhs.isEqual(rhs)
}

extension talkProtocol {
  func sayName() {
    print("Hello, my name is", self.name, separator: " ", terminator: "!", toStream: &str)
  }
  func isEqual(other: talkProtocol) -> Bool {
    return self.name == other.name
  }
}

struct person: talkProtocol, Equatable {
  
  var observer: talkObserver? {
    didSet {
    observer?.record("sdfds", some: observer!)
    }
  }
  let name: String
  
  init (_ name: String, observer: talkObserver? = nil) {
    self.name = name
    self.observer = observer
  }
}

struct test: talkObserver {
  func record(name: String, some: Any) {
    print(self, name, some)
  }
}
var d = test()


var g = person("Daniel")
g.observer = d
g.observer = nil

var a = g
g = person("Denis")
if a == g { print("same person") }
else { print("different person") }
g.sayName()

print(str)
//: [Next](@next)
