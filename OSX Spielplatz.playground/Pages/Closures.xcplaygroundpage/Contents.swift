//: [Previous](@previous)
import Foundation

var i = 1
var ref = {print(i)}
i = 2
//ref()

var cap = {[i] in print(i)}
i = 3
//cap()


class Matrix {
  let rows: Int
  let columns: Int
  var values: [[Bool]]
  
  init(columns: Int, rows: Int) {
    self.rows = rows
    self.columns = columns
    let row = [Bool](count: columns, repeatedValue: false)
    self.values = [[Bool]](count: rows, repeatedValue: row)
  }
  
  init(values: [[Bool]]) {
    self.values = values
    self.columns = values.first!.count
    self.rows = values.count
  }
  
  subscript(row: Int, column: Int) -> Bool {
    get {
      return values[row][column]
    }
    set(newValue) {
      values[row][column] = newValue
    }

  }

  func show() {
    var s = ""
    for row in 0..<rows {
      for column in 0..<columns {
        if self.values[row][column] {
          s += "#"
        } else {
          s += " "
        }
      }
      s += "\n"
    }
    print(s)
  }
  
  
}

let characters: [String: UInt64] = [
  "A": 227873781661662,
  "B": 422199034855391,
  "C": 9565685714534398,
  "D": 140724398931935,
  "E": 281410551955455,
  "F": 9020603847426047,
  "G": 417801450766302,
  "H": 228785541988957427,
  "I": 9223144176159343372,
  "J": 3513788460580408368,
  "K": 227860354645235,
  "L": 281409529589955,
  "M": 227860698627297,
  "N": 227860832812275,
  "O": 136326352420830,
  "P": 13404056010719,
  "Q": 277072430710750,
  "R": 227860363034591,
  "S": 140721356816382,
  "T": 53614281281535,
  "U": 136326352420083,
  "V": 54906657389811,
  "W": 148708944461043,
  "X": 227860337605875,
  "Y": 53614596799731,
  "Z": 281409582370815,
  "0": 136326352420830,
  "1": 132779118478220,
  "2": 281409720881119,
  "3": 140720819867615,
  "4": 214457363938547,
  "5": 140721373593599,
  "6": 136326548307966,
  "7": 107228568948735,
  "8": 136325994594270,
  "9": 214457363939294]

let g: [UInt8] = [0x39,0x14,0x51,0x7D,0x14,0x40]

func drawCharacter(num: UInt64) -> [[Bool]] {
  var row = [Bool]()
  var result = [[Bool]]()
  var num = num
  var rem: UInt64 = 0
  var column = 0
  while (num > 0) {
    rem = num % 2;
    num = num / 2;
    row.append(rem == 1)
    column += 1
    if column == 6 {
      result.append(row)
      if result.count == 8 {
        break
      }
      row.removeAll()
      column = 0
    }
  }
  return result
}

Matrix(values: drawCharacter(characters["A"]!)).show()
Matrix(values: drawCharacter(characters["B"]!)).show()
Matrix(values: drawCharacter(characters["C"]!)).show()
Matrix(values: drawCharacter(characters["D"]!)).show()
Matrix(values: drawCharacter(characters["E"]!)).show()
Matrix(values: drawCharacter(characters["F"]!)).show()
Matrix(values: drawCharacter(characters["G"]!)).show()
Matrix(values: drawCharacter(characters["H"]!)).show()
Matrix(values: drawCharacter(characters["I"]!)).show()
Matrix(values: drawCharacter(characters["J"]!)).show()
Matrix(values: drawCharacter(characters["K"]!)).show()
Matrix(values: drawCharacter(characters["L"]!)).show()
Matrix(values: drawCharacter(characters["M"]!)).show()
Matrix(values: drawCharacter(characters["N"]!)).show()
Matrix(values: drawCharacter(characters["O"]!)).show()
Matrix(values: drawCharacter(characters["P"]!)).show()
Matrix(values: drawCharacter(characters["Q"]!)).show()
Matrix(values: drawCharacter(characters["R"]!)).show()
Matrix(values: drawCharacter(characters["S"]!)).show()
Matrix(values: drawCharacter(characters["T"]!)).show()
Matrix(values: drawCharacter(characters["U"]!)).show()
Matrix(values: drawCharacter(characters["V"]!)).show()
Matrix(values: drawCharacter(characters["W"]!)).show()
Matrix(values: drawCharacter(characters["X"]!)).show()
Matrix(values: drawCharacter(characters["Y"]!)).show()
Matrix(values: drawCharacter(characters["Z"]!)).show()
Matrix(values: drawCharacter(characters["1"]!)).show()
Matrix(values: drawCharacter(characters["2"]!)).show()
Matrix(values: drawCharacter(characters["3"]!)).show()
Matrix(values: drawCharacter(characters["4"]!)).show()
Matrix(values: drawCharacter(characters["5"]!)).show()
Matrix(values: drawCharacter(characters["6"]!)).show()
Matrix(values: drawCharacter(characters["7"]!)).show()
Matrix(values: drawCharacter(characters["8"]!)).show()
Matrix(values: drawCharacter(characters["9"]!)).show()


//: [Next](@next)
