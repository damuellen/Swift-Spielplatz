//: [Previous](@previous)
import Cocoa
import XCPlayground
import XCTest


class View: NSView {
  var (path, currentPath) = (NSBezierPath(), NSBezierPath())
  
  override func drawRect(dirtyRect: NSRect) {
    guard let contextPtr = NSGraphicsContext.currentContext()?.graphicsPort else {return}
    let context = unsafeBitCast(contextPtr, CGContext.self)
    CGContextSetStrokeColorWithColor(context, NSColor.whiteColor().CGColor)
    CGContextClearRect(context, dirtyRect)
    path.lineWidth = 2.0
    path.stroke()
    currentPath.lineWidth = 3.0
    currentPath.stroke()
  }
  
  var startlocation: NSPoint?
  
  override func mouseDown(theEvent: NSEvent) {
    currentPath = NSBezierPath()
    startlocation = theEvent.locationInWindow
    
  }
  
  override func mouseDragged(theEvent: NSEvent) {
    let adjacent = abs(startlocation!.x - theEvent.locationInWindow.x)
    let opposite = abs(startlocation!.y - theEvent.locationInWindow.y)
    if adjacent < opposite {
      currentPath.removeAllPoints()
      currentPath.moveToPoint(startlocation!)
      currentPath.lineToPoint(CGPoint(x: startlocation!.x, y: theEvent.locationInWindow.y))
    } else {
      currentPath.removeAllPoints()
      currentPath.moveToPoint(startlocation!)
      currentPath.lineToPoint(CGPoint(x: theEvent.locationInWindow.x, y: startlocation!.y))
      currentPath.elementAtIndex(0)
    }
    needsDisplay = true
  }
  
  override func mouseUp(theEvent: NSEvent) {
    path.appendBezierPath(currentPath)
    currentPath = NSBezierPath()
    needsDisplay = true
  }
}

let view: View = { view in
  view.wantsLayer = true
  view.layer?.backgroundColor = NSColor.darkGrayColor().CGColor
  return view
}(View(frame: NSRect(x: 0, y: 0, width: 600, height: 600)))

XCPlaygroundPage.currentPage.liveView = view
//: [Next](@next)
