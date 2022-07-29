//
//  LoginViewController.swift
//  Bank-App
//
//  Created by William Reinert on 16/07/22.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLoginButton(in view: LoginView)
}

class LoginView: UIView {
        
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var userLoginField: UITextField!
    @IBOutlet weak var passwordLoginField: UITextField!
    
    var dataView: DataView!
    var user: User!
    
    weak var delegate: LoginViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    func setupLoginButton() {
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 68).isActive = true
        loginButton.isUserInteractionEnabled = true
        buttonStackView.addArrangedSubview(loginButton)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginButtonTapped(sender:)))
        loginButton.addGestureRecognizer(tapGesture)
    }

    @objc func handleLoginButtonTapped(sender: UIGestureRecognizer) {
        delegate?.didTapLoginButton(in: self)
    }
    
}

    

