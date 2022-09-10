//
//  BaseTableView.swift
//  Bank-App
//
//  Created by William Reinert on 27/08/22.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {return "\(self)"}
}

extension UITableView {
    
    func registerCell(reusable: Reusable.Type) {
        register(UINib(nibName: reusable.reuseID, bundle: nil), forCellReuseIdentifier: reusable.reuseID)
    }
    
    func dequeueCell<T>(at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unexpected ReusableCell Type for reuseID \(T.reuseID)")
        }
        return cell
    }
}


