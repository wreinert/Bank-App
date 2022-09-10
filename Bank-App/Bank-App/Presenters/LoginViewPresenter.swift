//
//  LoginViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation
import UIKit

protocol LoginViewPresenterProtocol {
    func isValidLoginData(username: String, password: String)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    var coordinator: Coordinator
    var viewController: LoginViewControllerProtocol?
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isValidLoginData (username: String, password: String) {
        if username.isEmail() == true || username.isCPF == true {
            if checkPassword(password: password) == true {
                self.coordinator.showDataScreen()
            } else {
                showAlert(message: "Senha precisa ter uma letra maiuscula, caracter especial e alfanumerico")
            }
        } else {
            showAlert(message: "Login precisa ser CPF ou email")
        }
    }
    
    private func showAlert(message: String) {
        let invalidLoginAlert = UIAlertController(
                   title: "Login Inválido",
                   message: message,
                   preferredStyle: UIAlertController.Style.alert)
        
        invalidLoginAlert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.showAlertPopUp(alert: invalidLoginAlert)
    }
        
    private func checkPassword(password: String) -> Bool {
        let passWordRegEx = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Z\\d$@$!%*?&]{3,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
}
