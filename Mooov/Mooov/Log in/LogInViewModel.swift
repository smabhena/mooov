//
//  LogInViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/24.
//

import Foundation

protocol LogInViewModelDelegate: AnyObject {
    func navigateToHomePage()
    func showError(error: String)
}

class LogInViewModel {
    private weak var delegate: LogInViewModelDelegate?
    
    init(delegate: LogInViewModelDelegate) {
            self.delegate = delegate
        }
    
    func logInUser(_ username: String, _ password: String) {
        if username == "Admin" && password == "TestPass123" {
            delegate?.navigateToHomePage()
        } else {
            delegate?.showError(error: "Enter correct username or password")
        }
    }
}
