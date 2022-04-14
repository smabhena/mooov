//
//  LoginTests.swift
//  MooovTests
//
//  Created by Sinothando Mabhena on 2022/04/14.
//

import XCTest

class LoginTests: XCTestCase {
    private var delegate: MockDelegate!
    private var viewModel: LogInViewModel!
    
    override func setUp() {
        super.setUp()
        delegate = MockDelegate()
        viewModel = LogInViewModel(delegate: delegate)
    }
    
    func testLoginUserSuccessWithCorrectDetails() {
        viewModel.logInUser("Admin", "TestPass123")
        XCTAssert(delegate.navigateToHomePageCalled)
        XCTAssertFalse(delegate.showErrorCalled)
    }
    
    func testLoginUserFailureWithIncorrectDetails() {
        viewModel.logInUser("John", "superdopepassword")
        XCTAssert(delegate.showErrorCalled)
        XCTAssertFalse(delegate.navigateToHomePageCalled)
    }
    
    class MockDelegate: LogInViewModelDelegate {
        var navigateToHomePageCalled = false
        var showErrorCalled = false
        
        func navigateToHomePage() {
            navigateToHomePageCalled = true
        }
        func showError(error: String) {
            showErrorCalled = true
        }
    }

}
