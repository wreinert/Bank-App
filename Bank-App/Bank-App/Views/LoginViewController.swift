//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

/* TODO:
 - Inicializar esta tela pelo coordinator, conforme fizemos no DataViewController
 */

class LoginViewController: UIViewController {
    
    var loginViewPresenter = LoginViewPresenter()
    var coordinator: Coordinator?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
        loginViewPresenter.delegate = self
        setupLoginButton()
    }
    
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginViewPresenter.isValidLoginData(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}

extension LoginViewController: LoginViewPresenterDelegate {
    func didCheckUsername() {
        coordinator?.showDataScreen()
    }
}
