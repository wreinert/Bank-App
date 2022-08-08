//
//  LoginModel.swift
//  Bank-App
//
//  Created by William Reinert on 24/07/22.
//

import Foundation

struct User: Codable {
    var customerName: String
    var accountNumber: String
    var branchNumber: String
    var checkingAccountBalance: Double
    var id: String
}
