//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

class ViewController: UIViewController, LoginViewDelegate, LoginViewPresenterDelegate, DataViewDelegate {
    
    var loginView: LoginView!
    var dataView: DataView!
    var loginViewPresenter = LoginViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataView = Bundle(for: DataView.self).loadNibNamed("\(DataView.self)", owner: self)![0] as? DataView
        loginView = Bundle(for: LoginView.self).loadNibNamed("\(LoginView.self)", owner: self)![0] as? LoginView
        view?.addSubview(loginView.loginButton)
        loginView.setupLoginButton()
        loginView.delegate = self
        loginViewPresenter.delegate = self
    }
    
    func didTapLoginButton(in view: LoginView) {
        loginViewPresenter.checkUsernameValid(username: loginView.userLoginField.text!, password: loginView.passwordLoginField.text!)
        dataView.setupLogoutButton()
        dataView.delegate = self
    }
    
    func didTapLogoutButton(in view: DataView) {
        UIView.transition(from: dataView, to: loginView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        loginView.setupLoginButton()
        loginView.delegate = self
    }
    
    func didEnterUsername() {
        UIView.transition(from: loginView , to: dataView, duration: 1, options: .transitionFlipFromRight, completion:  nil)
    }
}

