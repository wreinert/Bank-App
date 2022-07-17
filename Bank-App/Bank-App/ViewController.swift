//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = Bundle(for: LoginView.self).loadNibNamed("\(LoginView.self)", owner: self)![0] as? LoginView    
        
    }


}

