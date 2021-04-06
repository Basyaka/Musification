//
//  LoginViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: K.PlaceholderText.email)
    
    private let passwordTextField: UITextField = {
        let tf = UIUtilities.textField(withPlaceholder: K.PlaceholderText.password)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.emailTextFieldSystemImageName)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.passwordTextFieldSystemImageName)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let logInButton = UIUtilities.mainButton(withTitle: "Log In")
    private lazy var forgotPasswordButtom = UIUtilities.additionalButton(withText: "Get help signng in.", withTextSize: view.frame.height/50)
    private lazy var toSignUpButton = UIUtilities.additionalButton(withText: "Sign Up", withTextSize: view.frame.height/50)
    private lazy var logInWithGoogleButton = UIUtilities.additionalButton(withText: "Log in with Google", withTextSize: view.frame.height/40)
    private lazy var logInWithAppleButton = UIUtilities.additionalButton(withText: "Log in with Apple", withTextSize: view.frame.height/40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    private func configureController() {
        configureGradientBackground()
        setLayout()
    }
    
    private func setLayout() {
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       logInButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        view.addSubview(mainStack)
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 60,
                         leading: view.leadingAnchor, paddingLeft: 32,
                         trailing: view.trailingAnchor, paddingRight: -32)
        
        let forgotPasswordStack = UIUtilities.additionalStackWithLabel(withLabelText: "Forgot your password?", withTextSize: view.frame.height/50, button: forgotPasswordButtom)
        view.addSubview(forgotPasswordStack)
        forgotPasswordStack.centerX(inView: view, topAnchor: mainStack.bottomAnchor, paddingTop: 24)
        
        let orLine = UIUtilities.orLine(withText: "OR")
        view.addSubview(orLine)
        orLine.anchor(top: forgotPasswordStack.bottomAnchor, paddingTop: 32,
                      leading: view.leadingAnchor, paddingLeft: 48,
                      trailing: view.trailingAnchor, paddingRight: -48)
        
        let logInWithGoogleStack = UIUtilities.additionalStackWithImageView(withImage: UIImage(named: "GoogleLogo")!, imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithGoogleButton)
        view.addSubview(logInWithGoogleStack)
        logInWithGoogleStack.centerX(inView: view, topAnchor: orLine.bottomAnchor, paddingTop: 32)
        
        let logInWithAppleStack = UIUtilities.additionalStackWithImageView(withImage: UIImage(named: "AppleLogo")!, imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithAppleButton)
        view.addSubview(logInWithAppleStack)
        logInWithAppleStack.centerX(inView: view, topAnchor: logInWithGoogleStack.bottomAnchor, paddingTop: 24)
       
        let toSignUpStack = UIUtilities.additionalStackWithLabel(withLabelText: "Don't have an account?", withTextSize: view.frame.height/50, button: toSignUpButton)
        view.addSubview(toSignUpStack)
        toSignUpStack.centerX(inView: view, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -16)
    }
}
