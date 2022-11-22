//
//  PokedexLoginViewController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 30/08/21.
//

import UIKit

protocol PokedexLoginViewPresenterOutput: class {
    func presenter(showLoginSuccess message : String)
    func presenter(showLoginFailure message: String)
    func presenter(showSignUpSuccess message : String)
}

class PokedexLoginViewController: UIViewController {
    
    var loginView: PokedexLoginView!
    var interactor: PokedexLoginViewInteractor?
    var router: PokedexLoginViewRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
        checkTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupLoginView() {
        let mainView = PokedexLoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signUpAction = signUpPressed
        self.view.addSubview(loginView)
        loginView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.backgroundColor = .tertiarySystemBackground
    }
    
    func checkTextFields() {
        loginView.loginButton.isEnabled = false
        loginView.loginButton.alpha = 0.5
        loginView.emailTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let email = loginView.emailTextField.text, !email.isEmpty,
            let password = loginView.passwordTextField.text, !password.isEmpty
        else {
            loginView.loginButton.isEnabled = false
            loginView.loginButton.alpha = 0.5
            return
        }
        
        loginView.loginButton.isEnabled = true
        loginView.loginButton.alpha = 1.0
    }
    
    func loginPressed() {
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        interactor?.loginTapped(email: email, password: password)
    }
    
    func signUpPressed() {
        interactor?.signUpTapped(message: "Sign Up Pressed")
    }
}

extension PokedexLoginViewController: PokedexLoginViewPresenterOutput {
    
    func presenter(showLoginSuccess message: String) {
        self.router?.routeToPokedexList()
        print(message)
    }
    
    func presenter(showLoginFailure message: String) {
        let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presenter(showSignUpSuccess message: String) {
        print(message)
        self.router?.routeToSignUp()
    }
    
}
