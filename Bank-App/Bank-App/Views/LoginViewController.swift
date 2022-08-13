//
//  ViewController.swift
//  Bank-App
//
//  Created by William Reinert on 17/07/22.
//

import UIKit

/* TODO:
 - Tirar todo o código da LoginView e passar pra LoginViewController
 - Deletar LoginView e todo o código relacionado a ela
 - Jogar DataView para uma controller separadada, e quando precisar, acionar a outra controller
 - Separar código da LoginViewController e código da DataViewController
 - Jogar service para o Presenter
 - Criar uma extension para cada delegate(mais organização)
 
 - Utizamos uma UIView, ou pra reduzir o tamanho do ViewController ou quando queremos reutilizar a mesma UI em telas diferentes
 */


class LoginViewController: UIViewController, LoginViewDelegate, LoginViewPresenterDelegate, DataViewDelegate {
    
    var loginView: LoginView!
    var dataView: DataView!
    var loginViewPresenter = LoginViewPresenter()
    var dataViewPresenter = DataViewPresenter()
    var dataService = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataView = Bundle(for: DataView.self).loadNibNamed("\(DataView.self)", owner: self)![0] as? DataView
//        loginView = Bundle(for: LoginView.self).loadNibNamed("\(LoginView.self)", owner: self)![0] as? LoginView
//        view?.addSubview(loginView.loginButton)
//        loginView.setupLoginButton()
//        loginView.delegate = self
//        loginViewPresenter.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Chamar novo controller
        let testeViewController = TesteViewController()
        present(testeViewController, animated: true)
    }
    
    func didTapLoginButton(in view: LoginView) {
        loginViewPresenter.checkUsernameValid(username: loginView.userLoginField.text!, password: loginView.passwordLoginField.text!)
        dataView.setupLogoutButton()
        dataView.delegate = self
//        self.dataView.didRequestData()
//        self.dataViewPresenter.fetchData()
    }
    
    func didTapLogoutButton(in view: DataView) {
        UIView.transition(from: dataView, to: loginView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        loginView.setupLoginButton()
        loginView.delegate = self
        loginView.userLoginField.text = nil
        loginView.passwordLoginField.text = nil
    }
    
    func didCheckUsername() {
        UIView.transition(from: loginView , to: dataView, duration: 1, options: .transitionFlipFromRight, completion: { finished in
            self.dataView.didRequestData()
//            self.dataViewPresenter.fetchData()
        })
    }
    
}

