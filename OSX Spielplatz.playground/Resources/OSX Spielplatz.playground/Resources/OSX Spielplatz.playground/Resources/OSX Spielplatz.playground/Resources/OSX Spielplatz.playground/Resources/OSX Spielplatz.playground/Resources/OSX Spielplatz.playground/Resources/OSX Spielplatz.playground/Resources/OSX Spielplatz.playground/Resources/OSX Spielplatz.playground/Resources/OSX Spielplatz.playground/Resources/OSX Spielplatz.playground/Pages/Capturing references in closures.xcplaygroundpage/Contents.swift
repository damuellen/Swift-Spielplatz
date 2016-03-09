//: [Previous](@previous)
import Foundation

var i = 1
var ref = {print(i)}
i = 2
ref()

var cap = {[i] in print(i)}
i = 3
cap()

//: [Next](@next)
