  import UIKit
  
  public let preparedUsernameTextField: UITextField -> UITextField = { usernameTextField in
    usernameTextField.clearButtonMode = .WhileEditing
    usernameTextField.placeholder = NSLocalizedString("Username", comment: "")
    usernameTextField.borderStyle = .RoundedRect
    return usernameTextField
  }
  
  public let preparedPasswordTextField: UITextField -> UITextField = { passwordTextField in
    passwordTextField.secureTextEntry = true
    passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
    passwordTextField.borderStyle = .RoundedRect
    return passwordTextField
  }
  
  public let preparedLoginButton: UIButton -> UIButton = { button in
    button.setTitle("Login", forState: .Normal)
    button.backgroundColor = .grayColor()
    button.tintColor = .whiteColor()
    button.layer.cornerRadius = 5
    return button
  }
  
  public let preparedLoginLabel: UILabel -> UILabel = { titel in
    titel.text = "Please enter"
    titel.font = UIFont.systemFontOfSize(28)
    titel.textColor = .grayColor()
    return titel
  }
  
  public let preparedStackView: UIStackView -> UIStackView = { view in
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = .Vertical
    view.spacing = 25
    return view
  }