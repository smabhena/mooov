//
//  LogInViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/27.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private lazy var viewModel = LogInViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.setCustomButtonStyling()
    }
    
    @IBAction private func loginButtonPressed(_ sender: Any) {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        
    viewModel.logInUser(username, password)
        
    }
}

extension LogInViewController: LogInViewModelDelegate {
    func navigateToHomePage() {
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar")
        
        if let navigator = self.navigationController {
            navigator.pushViewController(tabBarController, animated: true)
            navigator.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showError(error: String) {
        self.displayAlert(title: "Log in failed",
                          message: error,
                          buttonTitle: "Ok")
    }
   
}
