//
//  LoginViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

protocol LoginViewPresenterProtocol {
    func isValidLoginData(username: String, password: String)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    var coordinator: Coordinator
        
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
                print("Senha precisa ter uma letra maiuscula, caracter especial e alfanumerico")
            }
        } else {
            print("Login precisa ser CPF ou email")
        }
    }
        
    private func checkPassword(password: String) -> Bool {
        let passWordRegEx = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Z\\d$@$!%*?&]{3,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
}
