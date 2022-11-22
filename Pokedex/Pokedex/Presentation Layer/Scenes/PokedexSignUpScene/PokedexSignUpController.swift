//
//  PokedexSignUpViewController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import UIKit

protocol PokedexSignUpPresenterOutput: class {
    func presenter(showSubmitSuccess message: String)
    func presenter(showSubmitFailure message: String)
}

class PokedexSignUpController: UIViewController {
    
    var signUpView: PokedexSignUpView!
    var interactor: PokedexSignUpInteractor?
    var router: PokedexSignUpRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        checkTextFields()
    }
    
    func setupViews() {
        let mainView = PokedexSignUpView(frame: self.view.frame)
        self.signUpView = mainView
        self.signUpView.submitAction = submitPressed
        self.signUpView.cancelAction = cancelPressed
        view.addSubview(signUpView)
        signUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.backgroundColor = .white
        
    }
    
    func checkTextFields() {
        signUpView.signUpButton.isEnabled = false
        signUpView.signUpButton.alpha = 0.5
        
        signUpView.nameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        signUpView.emailTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        signUpView.passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        signUpView.confirmPasswordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let name = signUpView.nameTextField.text, !name.isEmpty,
            let email = signUpView.emailTextField.text, !email.isEmpty,
            let password = signUpView.passwordTextField.text, !password.isEmpty,
            let confirmPassword = signUpView.confirmPasswordTextField.text, !confirmPassword.isEmpty
        else {
            
            signUpView.signUpButton.isEnabled = false
            signUpView.signUpButton.alpha = 0.5
            return
        }
        
        signUpView.signUpButton.isEnabled = true
        signUpView.signUpButton.alpha = 1.0
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{6,}")
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordCheck.evaluate(with: password)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailCheck.evaluate(with: email)
    }
    
    func submitPressed() {
        guard let email = signUpView.emailTextField.text, isValidEmail(email: email) else {
            signUpView.emailLabel.isHidden = false
            signUpView.emailLabel.text = "*Email field is empty or format is wrong"
            return
            
        }
        signUpView.emailLabel.isHidden = true
        
        guard let password = signUpView.passwordTextField.text, isValidPassword(password: password)  else {
            signUpView.passwordLabel.isHidden = false
            signUpView.passwordLabel.text = "*Password should consist of a (A-Z,a-z,0-9,a special character)"
            return
            
        }
        signUpView.passwordLabel.isHidden = true
        
        guard let confirmPassword = signUpView.confirmPasswordTextField.text, password == confirmPassword else {
            signUpView.confirmPasswordLabel.isHidden = false
            signUpView.confirmPasswordLabel.text = "*Password and confirm password do not match"
            return
        }
        signUpView.confirmPasswordLabel.isHidden = true
        
        guard let name = signUpView.nameTextField.text else { return }
        interactor?.submitTapped(name: name, email: email, password: password)
    }
    
    func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension PokedexSignUpController: PokedexSignUpPresenterOutput {
    
    func presenter(showSubmitSuccess message: String) {
        print(message)
        self.dismiss(animated: true, completion: nil)
    }
    
    func presenter(showSubmitFailure message: String) {
        let alert = UIAlertController(title: "Sign Up Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
