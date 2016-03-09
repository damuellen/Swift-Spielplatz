//: Playground - noun: a place where people can play

import Foundation

var names = [String]()
var urls = [NSURL]()

do {
  let data = try NSData(contentsOfURL: [#FileReference(fileReferenceLiteral: "Sample.json")#], options: []),
  json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
  
  if let blogs = json["blogs"] as? [[String: AnyObject]] {
    for blog in blogs {
      if let name = blog["name"] as? String {
        names.append(name)
      }
      if let urlString = blog["url"] as? String,
        url = NSURL(string: urlString) {
        urls.append(url)
      }
    }
  }
} catch {
  print("error parsing JSON: \(error)")
}

(names)

(urls)