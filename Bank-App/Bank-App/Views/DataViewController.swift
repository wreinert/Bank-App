//
//  DataViewController.swift
//  Bank-App
//
//  Created by William Reinert on 14/08/22.
//

import UIKit

/*
 - Utilizar protocolos para comunicação entre camadas
 - Passar delegate para este arquivo, chamar de DataViewControllerProtocol
 - Pesquisar sobre generics
 - Usar tableView.register e tableView.dequeue utilizando Generics // Pesquisar o como usar generics
 - Pesquisar sobre injeção de dependências
 */

class DataViewController: UIViewController {

    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contaLabel: UILabel!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    let dataViewPresenter: DataViewPresenter
    
    init(presenter: DataViewPresenter) {
        dataViewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        requestData()
    }
    
    private func setup() {
        dataViewPresenter.delegate = self
        setupLogoutButton()
        setupTableView() 
    }

    private func setupLogoutButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLogoutButtonTapped(sender:)))
        logoutImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLogoutButtonTapped(sender: UIGestureRecognizer) {
//        let loginViewController = LoginViewController()
//        loginViewController.modalPresentationStyle = .fullScreen
//        present(loginViewController, animated: true)
//        loginViewController.usernameTextField.text = nil
//        loginViewController.passwordTextField.text = nil
        
        // TODO: Faer no coordinator
        dismiss(animated: true)
    }
    
    func requestData() {
        dataViewPresenter.fetchData()
    }

}

extension DataViewController: DataViewPresenterDelegate {
    func updateUserData() {
        usernameLabel.text = String(self.dataViewPresenter.userInfo[0].customerName ?? "")
        contaLabel.text = String("\(self.dataViewPresenter.userInfo[0].branchNumber ?? "") / \(self.dataViewPresenter.userInfo[0].accountNumber ?? "")")
        saldoLabel.text = String("R$\(self.dataViewPresenter.userInfo[0].checkingAccountBalance ?? 0.0)")
    }
    
    func updateTableView() {
        transactionTableView.reloadData()
    }
}

extension DataViewController: UITableViewDataSource {
    private func setupTableView() {
        transactionTableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        // objetivo: transactionTableView.register(TableViewCell.self)
        transactionTableView.dataSource = self
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
        // objetivo: let cell = transactionTableView.dequeueReusableCell(type: TableViewCell.self, for: indexPath)
        cell.transactionDate?.text = transaction.paymentDate
        cell.transactionValue?.text = transaction.electricityBill
        return cell
    }
}
