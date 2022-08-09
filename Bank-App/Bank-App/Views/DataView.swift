//
//  DataView.swift
//  Bank-App
//
//  Created by William Reinert on 19/07/22.
//

import UIKit

protocol DataViewDelegate: AnyObject {
    func didTapLogoutButton(in view: DataView)
}

class DataView: UIView, UITableViewDataSource {
    
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    weak var delegate: DataViewDelegate?
    
    var dataService = DataService()
    var transactionCell = TransactionCell()
    let url = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
    let userUrl = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fetchUserInfo()
        fetchStatement()
        
        transactionTableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        transactionTableView.dataSource = self
    }
    
    func fetchUserInfo () {
        dataService.fetchUserInfo(url: URL(string: userUrl)!) {(json) in
            switch json {
            case .failure:
                print("error")
            case .success(let user):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.dataService.userInfo = user
                    self.userName.text = String(self.dataService.userInfo[0].customerName)
                    self.accountNumber.text = String("\(self.dataService.userInfo[0].branchNumber) / \(self.dataService.userInfo[0].accountNumber)")
                    self.accountBalance.text = String("R$\(self.dataService.userInfo[0].checkingAccountBalance)")
                    
                }
            }
        }
    }
    
    func fetchStatement() {
        dataService.fetchStatement(url: URL(string: url)!) { (json) in
            switch json {
            case .failure:
                print("error")
            case .success(let transactions):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.dataService.transactions = transactions
                    self.transactionTableView.reloadData()
                }
            }
        }
    }
    
    func setupLogoutButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLogoutButtonTapped(sender:)))
        logoutImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLogoutButtonTapped(sender: UIGestureRecognizer) {
        delegate?.didTapLogoutButton(in: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.transactions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Recentes"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = dataService.transactions[indexPath.row]
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TransactionCell
        cell.transactionDate?.text = transaction.paymentDate
        cell.transactionValue?.text = transaction.electricityBill
        return cell
    }
    
}
