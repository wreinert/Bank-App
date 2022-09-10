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
    
    var user: User!
    
    weak var delegate: LoginViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2941176471, blue: 0.9254901961, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    func setupLoginButton() {
        loginButton.isUserInteractionEnabled = true
        buttonStackView.addArrangedSubview(loginButton)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginButtonTapped(sender:)))
        loginButton.addGestureRecognizer(tapGesture)
    }

    @objc func handleLoginButtonTapped(sender: UIGestureRecognizer) {
        delegate?.didTapLoginButton(in: self)
    }
    
}

    

