//: [Previous](@previous)

import Foundation
import AppKit
//let url = NSURL(string: "https://github.com")!

// NSWorkspace.sharedWorkspace().openURL(url)
/*
do {
  let badstr = try NSString(contentsOfFile: "boom-bang.bars.quux", encoding: NSUTF8StringEncoding)
}
catch let error as NSError {
  let e = error.localizedDescription as NSString
  let encodedErr = e.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
  if let encodedErr = encodedErr, url = NSURL(string: "http://stackoverflow.com/search?q=[swift]%20\(encodedErr)") {
    NSWorkspace.sharedWorkspace().openURL(url)
  }
}
*/

let workspace = NSWorkspace.sharedWorkspace()
let runApplications = workspace.runningApplications
  for runApplication in runApplications where runApplication.active == false {
    runApplication.hide()
    print("active:\(runApplication.active)")
    print("hidden:\(runApplication.hidden)")
    print("localizedName:\(runApplication.localizedName)")
    print("processIdentifier:\(runApplication.processIdentifier)")
    print("bundleIdentifier:\(runApplication.bundleIdentifier)")
    print("bundleURL:\(runApplication.bundleURL)")
    print("executableArchitecture:\(runApplication.executableArchitecture)")
    // runApplication.icon
    print("-------------------------")
  }



//: [Next](@next)
