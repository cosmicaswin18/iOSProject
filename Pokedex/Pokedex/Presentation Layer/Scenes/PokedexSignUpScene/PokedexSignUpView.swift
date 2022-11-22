//
//  PokedexSignUpView.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import UIKit

class PokedexSignUpView: UIView {
    
    let nameTextField: UITextField = {
        let tf = UITextField(placeholderString: "Name")
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeholderString: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeholderString: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let confirmPasswordTextField: UITextField = {
        let tf = UITextField(placeholderString: "Confirm Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(title: "Sign Up", borderColor: UIColor.mainPink())
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(title: "Cancel", borderColor: UIColor.mainPink())
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    var submitAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        let stackView = createStackView(views: [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
        let buttonStackView = createHorizontalStackView(views: [signUpButton,
                                                                cancelButton])
        
        addSubview(stackView)
        addSubview(buttonStackView)
        addSubview(emailLabel)
        addSubview(passwordLabel)
        addSubview(confirmPasswordLabel)
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 60, height: 200)
        
        emailLabel.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 26, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        passwordLabel.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 26, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        confirmPasswordLabel.anchor(top: confirmPasswordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 26, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        buttonStackView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 60, height: 45)
        buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    @objc func handleSubmit() {
        submitAction?()
    }
    
    @objc func handleCancel() {
        cancelAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
