//
//  DataViewController.swift
//  Bank-App
//
//  Created by William Reinert on 14/08/22.
//

import UIKit

/*
 - Utilizar protocolos para comunicação entre camadas - ok
 - Passar delegate para este arquivo, chamar de DataViewControllerProtocol - ok
 - Pesquisar sobre generics
 - Usar tableView.register e tableView.dequeue utilizando Generics // Pesquisar o como usar generics
 - Pesquisar sobre injeção de dependências - ok
 */

protocol DataViewControllerProtocol {
    func updateUserData()
    func updateTableView()
}

class DataViewController: UIViewController {

    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contaLabel: UILabel!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    let dataViewPresenter: DataViewPresenterProtocol
    var coordinator: Coordinator?
    
    init(presenter: DataViewPresenterProtocol) {
        self.dataViewPresenter = presenter
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
        setupLogoutButton()
        setupTableView() 
    }

    private func setupLogoutButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLogoutButtonTapped(sender:)))
        logoutImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLogoutButtonTapped(sender: UIGestureRecognizer) {
        coordinator?.dismissDataScreen()
    }
    
    func requestData() {
        dataViewPresenter.fetchData()
    }

}

extension DataViewController: DataViewControllerProtocol {
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
        transactionTableView.registerCell(reusable: TransactionCell.self)
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
        let cell: TransactionCell = transactionTableView.dequeueCell(at: indexPath)
        cell.transactionDate?.text = transaction.paymentDate
        cell.transactionValue?.text = transaction.electricityBill
        return cell
    }
}
