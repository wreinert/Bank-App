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
        transactionBubble.layer.shadowRadius = 5
        transactionBubble.layer.shadowColor = UIColor.red.cgColor
        transactionBubble.layer.shadowOffset = CGSize(width: 0,height: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
