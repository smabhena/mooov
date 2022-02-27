//
//  LogInViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/27.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction private func loginButtonPressed(_ sender: Any) {
        
        if usernameField.text == "Admin" && passwordField.text == "TestPass123"{
            print("Successful log in")
        } else {
            self.displayAlert(title: "Log in failed",
                              message: "Enter correct username or password",
                              buttonTitle: "Ok")
            print("Log in failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    func displayAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
