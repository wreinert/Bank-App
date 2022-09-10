//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginViewPresenter: LoginViewPresenterProtocol
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    init(presenter: LoginViewPresenterProtocol) {
        self.loginViewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
    }
    
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginViewPresenter.isValidLoginData(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
