import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(drand48())
  }
}

extension UIColor {
  public class func randomColor() -> UIColor {
    return UIColor(red: CGFloat.random(), green: CGFloat.random(), blue: CGFloat.random(), alpha: 1.0)
  }
}