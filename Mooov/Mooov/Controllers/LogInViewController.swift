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
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor.primaryColor.cgColor
    }
    
    @IBAction private func loginButtonPressed(_ sender: Any) {
        if usernameField.text == "Admin" && passwordField.text == "TestPass123" {
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar")
            
            if let navigator = self.navigationController {
                navigator.pushViewController(tabBarController, animated: true)
                navigator.setNavigationBarHidden(true, animated: false)
            }
            
        } else {
            self.displayAlert(title: "Log in failed",
                              message: "Enter correct username or password",
                              buttonTitle: "Ok")
        }
    }
}
