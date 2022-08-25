//
//  Coordiantor.swift
//  Bank-App
//
//  Created by Felipe Alexander Da Silva Melo on 17/08/22.
//

import Foundation
import UIKit

/*
 - Criar o dismiss pra voltar da tela de dados para a tela de login
 - Criar as injeções de dependências do login conforme feito no showDataScreen
 */

protocol Coordinator {
    func start()
    func showDataScreen()
    func dismissCurrentScreen()
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
    
    func dismissCurrentScreen() {
        currentViewController?.dismiss(animated: true)
    }
    
}
