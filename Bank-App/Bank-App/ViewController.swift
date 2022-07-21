//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

class ViewController: UIViewController, LoginViewDelegate {
    
    var loginView: LoginView!
    var dataView: DataView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = Bundle(for: LoginView.self).loadNibNamed("\(LoginView.self)", owner: self)![0] as? LoginView
        view?.addSubview(loginView.loginButton)
        loginView.setupLoginButton()
        loginView.delegate = self
    }
    
    func didTapLoginButton(in view: LoginView) {
        dataView = Bundle(for: DataView.self).loadNibNamed("\(DataView.self)", owner: self)![0] as? DataView
    }
    
}

