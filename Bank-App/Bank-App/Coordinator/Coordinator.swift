//
//  Coordiantor.swift
//  Bank-App
//
//  Created by Felipe Alexander Da Silva Melo on 17/08/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    func showDataScreen()
    func dismissDataScreen()
}

class AppCoordinator: Coordinator {
    
    private var currentViewController: UIViewController?
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let presenter = LoginViewPresenter(coordinator: self)
        let loginViewController = LoginViewController(presenter: presenter)
        
        loginViewController.modalPresentationStyle = .fullScreen
        presenter.viewController = loginViewController
        
        currentViewController = loginViewController
        
        window?.rootViewController = currentViewController
        window?.makeKeyAndVisible()
    }
    
    func showDataScreen() {
        let service = DataService()
        let presenter = DataViewPresenter(service: service)
        let dataViewController = DataViewController(presenter: presenter)
        presenter.viewController = dataViewController
        dataViewController.coordinator = self
        
        dataViewController.modalPresentationStyle = .fullScreen
        
        currentViewController?.present(dataViewController, animated: true) {
            self.currentViewController = dataViewController
        }
    }
    
    func dismissDataScreen() {
        let presenter = LoginViewPresenter(coordinator: self)
        let loginViewController = LoginViewController(presenter: presenter)
        
        presenter.viewController = loginViewController
        
        loginViewController.modalPresentationStyle = .fullScreen
        
        currentViewController?.present(loginViewController, animated: true) {
            self.currentViewController = loginViewController
            loginViewController.usernameTextField.text = ""
            loginViewController.passwordTextField.text = ""
        }
        
    }
    
}
