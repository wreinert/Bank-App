//
//  DataViewController.swift
//  Bank-App
//
//  Created by William Reinert on 14/08/22.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contaLabel: UILabel!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    let dataViewPresenter = DataViewPresenter()
    var transactionCell = TransactionCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoutButton()
        dataViewPresenter.delegate = self
        didRequestData()
        transactionTableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        transactionTableView.dataSource = self
    }

    private func setupLogoutButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLogoutButtonTapped(sender:)))
        logoutImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLogoutButtonTapped(sender: UIGestureRecognizer) {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
        loginViewController.usernameTextField.text = nil
        loginViewController.passwordTextField.text = nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewPresenter.transactions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Recentes"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = dataViewPresenter.transactions[indexPath.row]
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TransactionCell
        cell.transactionDate?.text = transaction.paymentDate
        cell.transactionValue?.text = transaction.electricityBill
        return cell
    }

}

extension DataViewController: DataViewPresenterDelegate {
    func didRequestData() {
        dataViewPresenter.fetchData()
    }
    
    func updateUserData() {
        usernameLabel.text = String(self.dataViewPresenter.userInfo[0].customerName ?? "")
        contaLabel.text = String("\(self.dataViewPresenter.userInfo[0].branchNumber ?? "") / \(self.dataViewPresenter.userInfo[0].accountNumber ?? "")")
        saldoLabel.text = String("R$\(self.dataViewPresenter.userInfo[0].checkingAccountBalance ?? 0.0)")
    }
    
    func updateTableView() {
        transactionTableView.reloadData()
    }
}
