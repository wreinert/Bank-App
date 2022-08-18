//
//  DataViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 08/08/22.
//

import Foundation

protocol DataViewPresenterDelegate: AnyObject {
    func updateUserData()
    func updateTableView()
}

//protocol Fumante {
//    var cigarro: String { get }
//}
//
//class Pessoa: Fumante {
//    var cigarro: String
//    var nome: String
//    var amigo: Fumante
//
//    init(nome: String, amigo: Fumante) {
//        self.nome = nome
//        self.cigarro = "Malboro"
//        self.amigo = amigo
//    }
//
//    func pedirCigarro(para fumante: Fumante) {
//        self.cigarro = fumante.cigarro
//    }
//}
//
//class Fornecedor: Fumante {
//    var cigarro: String
//
//    init() {
//        self.cigarro = "Charuto"
//    }
//}
//
//let felipe = Fornecedor()
//
//let william = Pessoa(nome: "William", amigo: felipe)
//let victor = Pessoa(nome: "Victor", amigo: felipe)
//
//william.pedirCigarro(para: victor)
//william.pedirCigarro(para: felipe)

protocol DataViewPresenterProtocol {
    func fetchData()
}

class DataViewPresenter: DataViewPresenterProtocol {
    
    // mudar nome para viewController
    weak var delegate: DataViewPresenterDelegate?

    var dataService: DataService?
    var url: String?
    let paymentUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
    let userUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
    var transactions: [PaymentModel] = []
    var userInfo: [UserModel] = []
    
    init(service: DataService) {
        dataService = service
    }
    
    func fetchData() {
        url = userUrl
        if let urlString = url, let urlToExecute = URL(string: urlString) {
            dataService?.fetchUserInfo(url: urlToExecute) {(json) in
                switch json {
                case .failure:
                    print("error")
                case .success(let user):
                    self.userInfo = user
                    self.delegate?.updateUserData()
                }
            }
        }
        
        url = paymentUrl
        if let urlString = url, let urlToExecute = URL(string: urlString) {
            dataService?.fetchStatement(url: urlToExecute) { (json) in
                switch json {
                case .failure:
                    print("error")
                case .success(let transactions):
                    self.transactions = transactions
                    self.delegate?.updateTableView()
                }
            }
        }
        
        
    }
}
