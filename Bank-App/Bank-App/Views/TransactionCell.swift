//
//  TransactionCell.swift
//  Bank-App
//
//  Created by William Reinert on 27/07/22.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var transactionBubble: UIView!
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var transactionDescription: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var transactionValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        transactionBubble.layer.cornerRadius = transactionBubble.frame.size.height / 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}

extension UITableViewCell: Reusable {}
