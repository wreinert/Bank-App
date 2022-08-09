//
//  DataViewPresenter.swift
//  Bank-App
//
//  Created by William Reinert on 08/08/22.
//

//import Foundation
//
//class DataViewPresenter {
//
//    var dataService = DataService()
//    let url = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
//    let userUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
//
//    func fetchUserInfo () {
//        dataService.fetchUserInfo(url: URL(string: userUrl)!) {(json) in
//            switch json {
//            case .failure:
//                print("error")
//            case .success(let user):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.dataService.userInfo = user
//                    self.userName.text = String(self.dataService.userInfo[0].customerName)
//                    self.accountNumber.text = String("\(self.dataService.userInfo[0].branchNumber) / \(self.dataService.userInfo[0].accountNumber)")
//                    self.accountBalance.text = String("R$\(self.dataService.userInfo[0].checkingAccountBalance)")
//
//                }
//            }
//        }
//    }
//}
