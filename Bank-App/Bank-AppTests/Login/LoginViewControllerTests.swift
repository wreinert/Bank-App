//
//  Bank_AppTests.swift
//  Bank-AppTests
//
//  Created by William Reinert on 02/09/22.
//

import XCTest
@testable import Bank_App

class LoginViewControllerTests: XCTestCase {

    var window: UIWindow!
    var presenter: PresenterSpy!
    var viewController: LoginViewController!
    
    override func setUp() {
        window = UIWindow(frame: .zero)
        presenter = PresenterSpy()
        viewController = LoginViewController(presenter: presenter)
        
        loadView()
    }
    
    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    class PresenterSpy: LoginViewPresenterProtocol {
        var isValidLoginDataCalled = false
        
        var username = ""
        var password = ""
        
        func isValidLoginData(username: String, password: String) {
            isValidLoginDataCalled = true
            
            self.username = username
            self.password = password
        }
    }
    
    func testDidPressLoginButton() {
        //Given
        let username = "09361816993"
        let password = "A@2"
        viewController.usernameTextField.text = username
        viewController.passwordTextField.text = password
        //When
        viewController.loginButtonPressed(UIButton())
        
        //Then
        XCTAssertTrue(presenter.isValidLoginDataCalled)
        
        XCTAssertEqual(username, presenter.username)
        XCTAssertEqual(password, presenter.password)
    }
}
