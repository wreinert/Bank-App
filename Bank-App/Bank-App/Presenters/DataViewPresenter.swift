//
//  DataViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 08/08/22.
//

import Foundation

protocol DataViewPresenterDelegate: AnyObject {
    func didRequestData()
}

class DataViewPresenter {
    
    weak var delegate: DataViewPresenterDelegate?
    weak var dataView: DataView?

//    var userData: [User]?
//    var transactionData: [Payments]?
    var dataService: DataService?
    let url = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
    let userUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
    
    func fetchData() {
        dataService?.fetchUserInfo(url: URL(string: userUrl)!) {(json) in
            switch json {
            case .failure:
                print("error")
            case .success(let user):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
                    self.dataService?.userInfo = user
                    self.dataView?.updateUserData()
//                }
            }
        }
        
        dataService?.fetchStatement(url: URL(string: url)!) { (json) in
            switch json {
            case .failure:
                print("error")
            case .success(let transactions):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
                    self.dataService?.transactions = transactions
                    self.dataView?.transactionTableView.reloadData()
//                }

            }
        }
        
        
    }
}
