//
//  LogInViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/24.
//

import Foundation

class LogInViewModel {
    func logInUser(_ username: String, _ password: String) -> Bool {
        return username == "Admin" && password == "TestPass123"
    }
}
