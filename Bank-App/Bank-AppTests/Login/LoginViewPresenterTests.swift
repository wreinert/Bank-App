//
//  LoginViewPresenterTests.swift
//  Bank-AppTests
//
//  Created by William Reinert on 02/09/22.
//

import XCTest
@testable import Bank_App

class LoginViewPresenterTests: XCTestCase {

    var presenter: LoginViewPresenter!
    var coordinator: LoginCoordinatorSpy!
    
    override func setUp() {
        coordinator = LoginCoordinatorSpy()
        presenter = LoginViewPresenter(coordinator: coordinator)
    }
    
    class LoginCoordinatorSpy: Coordinator {
        var showDataScreenCalled = false
        var isValidData = true
        
        func start() {
            //nao tem ligacao com loginpresenter
        }
        
        func showDataScreen() {
            showDataScreenCalled = true
        }
        
        func dismissDataScreen() {
            //nao tem ligacao com loginpresenter
        }
    }
    
    func testIsValidLoginDataWithSucess() {
        let username = "09361816993"
        let password = "A@2"
        
        presenter.isValidLoginData(username: username, password: password)
        
        XCTAssertTrue(coordinator.showDataScreenCalled)
    }
    
    func testIsValidLoginDataWithError() {
        let username = "09361816993"
        let password = "A@2"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
        
        XCTAssertTrue(coordinator.showDataScreenCalled)
        XCTAssertFalse(coordinator.isValidData)
    }
    
    func testUsernameFlawedEmail() {
        let username = "notemail.com"
        let password = "A@2"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
    
        XCTAssertFalse(coordinator.isValidData)
    }
    
    func testUsernameFlawedCpf() {
        let username = "123456789"
        let password = "A@2"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
    
        XCTAssertFalse(coordinator.isValidData)
    }
    
    func testPasswordNoNumber() {
        let username = "09361816993"
        let password = "A@A"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
    
        XCTAssertFalse(coordinator.isValidData)
    }
    
    func testPasswordNoSpecialCharacter() {
        let username = "notemail.com"
        let password = "AA2"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
    
        XCTAssertFalse(coordinator.isValidData)
    }
    
    func testPasswordNoUppercaseLetter() {
        let username = "notemail.com"
        let password = "a@2"
        coordinator.isValidData = false
        
        presenter.isValidLoginData(username: username, password: password)
    
        XCTAssertFalse(coordinator.isValidData)
    }
}
