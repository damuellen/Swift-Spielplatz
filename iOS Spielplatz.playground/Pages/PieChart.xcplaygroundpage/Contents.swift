//: [Previous](@previous)
import UIKit
import XCPlayground

extension CGFloat {
  var radians: CGFloat {
    return CGFloat(M_PI) * (self/180)
  }
  static func random() -> CGFloat {
    return CGFloat(drand48())
  }
}

extension UIBezierPath {
  convenience init(circleSegmentCenter center:CGPoint, radius:CGFloat, startAngle:CGFloat, endAngle:CGFloat)
  {
    self.init()
    self.moveToPoint(CGPointMake(center.x, center.y))
    self.addArcWithCenter(center, radius:radius, startAngle:startAngle.radians, endAngle: endAngle.radians, clockwise:true)
    self.closePath()
  }
}

extension UIColor {
  class func randomColor() -> UIColor {
    return UIColor(red: CGFloat.random(), green: CGFloat.random(), blue: CGFloat.random(), alpha: 1.0)
  }
}

func pieChart(pieces: [(UIBezierPath)], viewRect: CGRect) -> UIView {
  let view = UIView(frame: viewRect)
  view.backgroundColor = .darkGrayColor()
  
  for piece in pieces {
    let layer = CAShapeLayer()
    layer.path = piece.CGPath
    layer.fillColor = UIColor.randomColor().CGColor
    layer.strokeColor = UIColor.whiteColor().CGColor
    view.layer.addSublayer(layer)
  }
  return view
}

func createPieces(from values: CGFloat..., viewRect: CGRect) -> [UIBezierPath] {
  let centrePointOfChart = CGPointMake(CGRectGetMidX(viewRect),CGRectGetMidY(viewRect))
  let radius: CGFloat = max(rect.height, rect.width) * 0.45
  let sum = CGFloat(values.reduce(0, combine: +))
  let factor: CGFloat = 360 / sum
  var start: CGFloat = 0.0
  var pieces: [UIBezierPath] = []
  for value in values {
    let end = start + value * factor
    pieces.append(UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: start, endAngle: end))
    start = end
  }
  return pieces
}

let rect = CGRect(x: 0, y: 0, width: 500, height: 500)

let piePieces = createPieces(from: 20,40,30,50,100,50,40,60,20,150, viewRect: rect)

let chartView = pieChart(piePieces, viewRect: rect)

XCPlaygroundPage.currentPage.liveView = chartView
//: [Next](@next)
