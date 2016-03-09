import UIKit
import XCPlayground

extension NSLayoutConstraint {
  convenience init(view item: UIView, to toItem: UIView, attribute: NSLayoutAttribute, constant c: CGFloat = 0) {
    self.init(item: item, attribute: attribute,
                          relatedBy: .Equal,
                          toItem: toItem, attribute: attribute,
                                          multiplier: 1.0, constant: c)
    self.active = true
    self.shouldBeArchived = true
    item.translatesAutoresizingMaskIntoConstraints = false
  }
}

class ViewController: UIViewController {
  
  func action() { print("Hallo") }
  
  let label: UIButton = {
    $0.setTitle("Hallo", forState: .Normal)
    return $0
  }(UIButton(frame: CGRect.zero))
  
  var constraints: [NSLayoutConstraint] = []
  
  override func viewDidLoad() {
    self.view.backgroundColor = .grayColor()
    self.view.addSubview(label)
    self.label.addTarget(self, action: #selector(ViewController.action), forControlEvents: .TouchDown)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    
    if #available(iOS 9, *) {
      self.label.translatesAutoresizingMaskIntoConstraints = false
      self.label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
      self.label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    } else {
      constraints.append(NSLayoutConstraint(view: label, to: view, attribute: .CenterX))
      constraints.append(NSLayoutConstraint(view: label, to: view, attribute: .CenterY))
    }
    
  }
  
  func spin () {
    UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
      self.label.transform = CGAffineTransformRotate(self.label.transform, CGFloat(M_PI))
    }) { (finished) -> Void in
      self.spin()
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.spin()
  }
}

ViewController()

let vc = ViewController()

XCPlaygroundPage.currentPage.liveView = vc
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

