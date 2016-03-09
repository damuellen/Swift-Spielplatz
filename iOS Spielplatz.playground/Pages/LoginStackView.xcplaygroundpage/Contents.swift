//: [Previous](@previous)
import XCPlayground
import UIKit

class LoginStackView: UIView {
  
  let titel: UILabel
  let usernameTextField: UITextField
  let passwordTextField: UITextField
  let button: UIButton
  let stackView: UIStackView
  
  private var layoutConstraints: [NSLayoutConstraint] = []
  
  override init(frame: CGRect) {
    
    // closures defined in sources folder
    titel = preparedLoginLabel(UILabel())
    
    usernameTextField = preparedUsernameTextField(UITextField(frame: .zero))
    
    passwordTextField = preparedPasswordTextField(UITextField(frame: .zero))
    
    button = preparedLoginButton(UIButton(type: .System))
    
    let textFieldStackView = preparedStackView(UIStackView(arrangedSubviews: [usernameTextField, passwordTextField]))
    
    stackView = preparedStackView(UIStackView(arrangedSubviews: [titel, textFieldStackView, button]))
    
    super.init(frame: frame)
    
    backgroundColor = .groupTableViewBackgroundColor()
    
    addSubview(stackView)
    
    updateConstraints(&layoutConstraints)
  }
  
  private func updateConstraints(inout constraints: [NSLayoutConstraint], activate: Bool = true) {
    NSLayoutConstraint.deactivateConstraints(constraints)
    constraints = [
      stackView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor),
      stackView.widthAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: 0.85, constant: 0),
      usernameTextField.heightAnchor.constraintEqualToConstant(35),
      passwordTextField.heightAnchor.constraintEqualToConstant(35),
      button.heightAnchor.constraintEqualToConstant(42)
      ]
    if activate { NSLayoutConstraint.activateConstraints(constraints) }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class LoginStackViewController: UIViewController {
  
  var loginView: LoginStackView {
    return view as! LoginStackView
  }
  
  override func loadView() {
    view = LoginStackView(frame: .zero)
    loginView.button.addTarget(self, action: #selector(LoginStackViewController.login), forControlEvents: .TouchUpInside)
  }
  
  override func viewWillLayoutSubviews() {
    loginView.stackView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 80).active = true
  }
  
  func login() {
    print(loginView.usernameTextField.text!)
  }
  
}

let vc = LoginStackViewController()
XCPlaygroundPage.currentPage.liveView = vc



//: [Next](@next)
