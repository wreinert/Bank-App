//
//  LoginModel.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

/* TODO:
 - Utilizar apenas Decodable - OK
 - Utilizar sempre let a menos que vc vá alterar o valor - OK
 - Sempre deixar variáveis do model opcionais - OK
 - Sempre utilizar sufixos com o tipo da classe, neste caso, UserModel, pois user é um model - OK
 */
struct UserModel: Decodable {
    let customerName: String?
    let accountNumber: String?
    let branchNumber: String?
    let checkingAccountBalance: Double?
    let id: String?
}
