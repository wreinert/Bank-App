//
//  LoginViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

/* TODO:
 - Passar as extensions para um arquivo separado, deixar apenas uma extension para os dois métodos - OK
 - Revisar nomeclatura - OK
 - Utilizar private para todas as propriedades que não são utilizadas fora da classe - OK
 - Nuncar usar exclamação - OK
 - Ler sobre o ARC
 - Ler sobre CleanCode(livro e videos)
 */

protocol LoginViewPresenterProtocol {
    func isValidLoginData(username: String, password: String)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    var coordinator: Coordinator
//    var viewController: LoginViewControllerProtocol?
        
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
