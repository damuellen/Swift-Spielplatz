//: [Previous](@previous)
import Foundation

public extension SequenceType {
  /// - returns: The first element in `self` which matches the given `predicate`.
  func firstWhere(@noescape predicate: Generator.Element throws -> Bool) rethrows -> Generator.Element? {
    return try lazy.filter(predicate).first
  }
}

let words = ["Swift","iOS","cocoa","OSX","tvOS"]
let tweet = "This is an example tweet larking about Swift"

words.contains(tweet.containsString)
print(words.firstWhere {$0.containsString("OS")} )


