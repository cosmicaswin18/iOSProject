//
//  PokedexLoginView.swift
//  Pokedex
//
//  Created by durgesh-10379 on 31/08/21.
//

import UIKit

class PokedexLoginView: UIView {
    
    var loginAction: (() -> Void)?
    var signUpAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let stackView = createStackView(views: [emailTextField,
                                                passwordTextField])
        
        let stackButtonView = createStackView(views: [loginButton])
        
        addSubview(backgroundImageView)
        addSubview(stackView)
        addSubview(stackButtonView)
        addSubview(signUpButton)
        addSubview(signUpLabel)
        
        backgroundImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 200, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 60, height: 100)
        
        stackButtonView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.frame.width - 60, height: 45)
        stackButtonView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackButtonView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        signUpButton.anchor(top: stackButtonView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 200, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        signUpLabel.anchor(top: stackButtonView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 60, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PokedexImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField(placeholderString: "Email")
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(placeholderString: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .label
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(title: "Login", borderColor: UIColor.mainPink())
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.backgroundColor = .blueColor()
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        let attributedString = NSMutableAttributedString.init(string: "Sign Up")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: NSRange.init(location: 0, length: attributedString.length))
        button.setAttributedTitle(attributedString, for: .normal)
        
        return button
    }()
    
    @objc func handleLogin() {
        loginAction?()
    }
    
    @objc func handleSignUp() {
        signUpAction?()
    }
    
}
