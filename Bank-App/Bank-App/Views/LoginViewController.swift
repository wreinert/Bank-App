//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

/* TODO:
 - Tirar todo o código da LoginView e passar pra LoginViewController - OK
 - Deletar LoginView e todo o código relacionado a ela - OK
 - Jogar DataView para uma controller separadada, e quando precisar, acionar a outra controller - OK
 - Separar código da LoginViewController e código da DataViewController - OK
 - Jogar service para o Presenter - OK
 - Criar uma extension para cada delegate(mais organização) - OK
 
 - Utizamos uma UIView, ou pra reduzir o tamanho do ViewController ou quando queremos reutilizar a mesma UI em telas diferentes
 */

class LoginViewController: UIViewController {
    
    var loginViewPresenter = LoginViewPresenter()
    
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
        let dataViewController = DataViewController()
        dataViewController.modalPresentationStyle = .fullScreen
        present(dataViewController, animated: true)
    }
}
