//
//  LoginViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//
//o campo user deve aceitar email ou cpf, o campo password deve validar se a senha tem pelo menos uma letra maiuscula, um caracter especial e um caracter alfanumérico.

import Foundation

protocol LoginViewPresenterDelegate: AnyObject {
    func didEnterUsername()
}

class LoginViewPresenter {
 
    var dataView: DataView!
    weak var delegate: LoginViewPresenterDelegate?
    
    func checkUsernameValid (username: String, password: String) {
        
        if username.isEmail() == true || username.isCPF == true {
            if checkPassword(password: password) == true {
                delegate?.didEnterUsername()
            } else {
                print("Senha precisa ter uma letra maiuscula, caracter especial e alfanumerico")
            }
        } else {
            print("Login precisa ser CPF ou email")
        }
    }
        
    func checkPassword(password: String) -> Bool {
        let passWordRegEx = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Z\\d$@$!%*?&]{3,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
}

extension String {
    var isCPF: Bool {
        let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard numbers.count == 11 else { return false }

        let set = NSCountedSet(array: Array(numbers))
        guard set.count != 1 else { return false }

        let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
        let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
        let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
        let d1 = Int(numbers[i1..<i2])
        let d2 = Int(numbers[i2..<i3])

        var temp1 = 0, temp2 = 0

        for i in 0...8 {
            let start = numbers.index(numbers.startIndex, offsetBy: i)
            let end = numbers.index(numbers.startIndex, offsetBy: i+1)
            let char = Int(numbers[start..<end])

            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }

        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1

        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2

        return temp1 == d1 && temp2 == d2
    }
}

extension String {
    func isEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
                                             "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                                             "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
                                             "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
                                             "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                                             "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                                             "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
