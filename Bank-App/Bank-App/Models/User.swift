//
//  LoginModel.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

/* TODO:
 - Utilizar apenas Decodable
 - Utilizar sempre let a menos que vc vá alterar o valor
 - Sempre deixar variáveis do model opcionais
 - Sempre utilizar sufixos com o tipo da classe, neste caso, UserModel, pois user é um model
 */
struct User: Codable {
    var customerName: String
    var accountNumber: String
    var branchNumber: String
    var checkingAccountBalance: Double
    var id: String
}
