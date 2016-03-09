//: [Previous](@previous)
import AppKit
import XCPlayground

extension NSLayoutConstraint {
  convenience init(view item: NSView, to toItem: NSView, attribute: NSLayoutAttribute, constant c: CGFloat = 0) {
    self.init(item: item, attribute: attribute,
              relatedBy: .Equal,
              toItem: toItem, attribute: attribute,
              multiplier: 1.0, constant: c)
    self.active = true
    self.shouldBeArchived = true
    item.translatesAutoresizingMaskIntoConstraints = false
  }
}

let viewRect = NSRect(x: 0, y: 0, width: 300, height: 200)
var view = NSView(frame: viewRect)

view.wantsLayer = true
view.layer?.backgroundColor = NSColor.windowBackgroundColor().CGColor

class test: NSObject {
  @objc func test(sender: AnyObject) {
    print("Hallo")
  }
}

let t = test()
var button: NSButton = {
  $0.title = "Hallo"
  $0.target = t
  $0.action = #selector(test.test(_:))
  $0.enabled = true
  $0.bezelStyle = .RoundedBezelStyle
  return $0
}(NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 30)))

view.addSubview(button)

XCPlaygroundPage.currentPage.liveView = view
NSLayoutConstraint(view: button, to: view, attribute: .CenterX)
NSLayoutConstraint(view: button, to: view, attribute: .CenterY)

