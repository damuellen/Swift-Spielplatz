//: [Previous](@previous)
import Foundation

let data = NSData(contentsOfURL: [#FileReference(fileReferenceLiteral: "Sample.xml")#])!

do {
  let xmlDoc = try AEXMLDocument(xmlData: data)
  
  // prints the same XML structure as original
  print(xmlDoc.xmlString)
  
  // prints cats, dogs
  for child in xmlDoc.root.children {
    print(child.name)
  }
  
  // prints Optional("Tinna") (first element)
  print(xmlDoc.root["cats"]["cat"].value)
  
  // prints Tinna (first element)
  print(xmlDoc.root["cats"]["cat"].stringValue)
  
  // prints Optional("Kika") (last element)
  print(xmlDoc.root["dogs"]["dog"].last?.value)
  
  // prints Betty (3rd element)
  print(xmlDoc.root["dogs"].children[2].stringValue)
  
  // prints Tinna, Rose, Caesar
  if let cats = xmlDoc.root["cats"]["cat"].all {
    for cat in cats {
      if let name = cat.value {
        print(name)
      }
    }
  }
  
  // prints Villy, Spot
  for dog in xmlDoc.root["dogs"]["dog"].all! {
    if let color = dog.attributes["color"] {
      if color == "white" {
        print(dog.stringValue)
      }
    }
  }
  
  // prints Tinna
  if let cats = xmlDoc.root["cats"]["cat"].allWithValue("Tinna") {
    for cat in cats {
      print(cat.stringValue)
    }
  }
  
  // prints Caesar
  if let cats = xmlDoc.root["cats"]["cat"].allWithAttributes(["breed" : "Domestic", "color" : "yellow"]) {
    for cat in cats {
      print(cat.stringValue)
    }
  }
  
  // prints 4
  print(xmlDoc.root["cats"]["cat"].count)
  
  // prints Siberian
  print(xmlDoc.root["cats"]["cat"].attributes["breed"]!)
  
  // prints element <badexample> not found
 // print(xmlDoc["badexample"]["notexisting"].stringValue)
}
catch {
  print("\(error)")
}

//: [Next](@next)
