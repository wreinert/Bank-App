//
//  DataView.swift
//  Bank-App
//
//  Created by William Reinert on 19/07/22.
//

import UIKit

class DataView: UIView, UITableViewDataSource {
    
    let tableViewData = Array(repeating: " ", count: 20)
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        transactionTableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        transactionTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        return cell
    }
    
}
