//
//  DataViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 08/08/22.
//

import Foundation

protocol DataViewPresenterDelegate: AnyObject {
    func didRequestData()
    func updateUserData()
    func updateTableView()
}

class DataViewPresenter {
    
    weak var delegate: DataViewPresenterDelegate?

    var dataService: DataService?
    var url: String?
    let paymentUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
    let userUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
    var transactions: [PaymentModel] = []
    var userInfo: [UserModel] = []
    
    func fetchData() {
        dataService = DataService()
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
