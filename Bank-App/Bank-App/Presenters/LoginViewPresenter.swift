//
//  LoginViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

/* TODO:
 - Passar as extensions para um arquivo separado, deixar apenas uma extension para os dois métodos - OK
 - Revisar nomeclatura
 - Utilizar private para todas as propriedades que não são utilizadas fora da classe - OK
 - Nuncar usar exclamação - OK
 - Ler sobre o ARC
 - Ler sobre CleanCode(livro e videos)
 */

protocol LoginViewPresenterDelegate: AnyObject {
    func didCheckUsername()
}

class LoginViewPresenter {
 
    weak var delegate: LoginViewPresenterDelegate?
    
    func checkUsernameValid (username: String, password: String) {
        if username.isEmail() == true || username.isCPF == true {
            if checkPassword(password: password) == true {
                delegate?.didCheckUsername()
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
