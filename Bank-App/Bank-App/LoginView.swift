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
    
    var dataView: DataView!
    
    weak var delegate: LoginViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.gray
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
//        button.addTarget(LoginView.self, action: #selector(openNextView), for: .touchUpInside)
        return button
    }()
    
    func setupLoginButton() {
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 68).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loginButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginButtonTapped(sender:)))
        loginButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleLoginButtonTapped(sender: UIGestureRecognizer) {
        delegate?.didTapLoginButton(in: self)
    }
    
//    @objc func openNextView () {
        //aqui ficaria o presenter
        //dataView  = DataView()
        //presenter...
        //eu deveria estar usando UITapGestureRecognizer????
//    }
    
    
}

    

