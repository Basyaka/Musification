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
        iv.image = UIImage(named: K.ImageName.musificationLogo)
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
        let image = UIImage(systemName: K.SystemImageName.emailTextContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.passwordContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let logInButton = UIUtilities.mainButton(withTitle: K.AccountScreensText.ButtonText.logIn)
    private lazy var forgotPasswordButton = UIUtilities.additionalButton(withText: K.AccountScreensText.ButtonText.forgotPassword, withTextSize: view.frame.height/50)
    private lazy var toSignUpButton = UIUtilities.additionalButton(withText: K.AccountScreensText.ButtonText.signUp, withTextSize: view.frame.height/50)
    private lazy var logInWithGoogleButton = UIUtilities.additionalButton(withText: K.AccountScreensText.ButtonText.logWithGoogle, withTextSize: view.frame.height/40)
    private lazy var logInWithAppleButton = UIUtilities.additionalButton(withText: K.AccountScreensText.ButtonText.logWithApple, withTextSize: view.frame.height/40)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        
    }
    
    
    //MARK: - Helpers functions
    private func configureController() {
        configureGradientBackground()
        navigationController?.isNavigationBarHidden = true
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: view.frame.width/2, height: view.frame.height/5)
        
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, logInButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        view.addSubview(mainStack)
        mainStack.anchor(top: logoImageView.bottomAnchor,
                         leading: view.leadingAnchor, paddingLeft: 32,
                         trailing: view.trailingAnchor, paddingRight: -32)
        
        let forgotPasswordStack = UIUtilities.additionalStackWithLabel(withLabelText: K.AccountScreensText.LabelText.forgotPassword, withTextSize: view.frame.height/50, button: forgotPasswordButton)
        view.addSubview(forgotPasswordStack)
        forgotPasswordStack.centerX(inView: view, topAnchor: mainStack.bottomAnchor, paddingTop: 24)
        
        let orLine = UIUtilities.orLine(withText: "OR")
        view.addSubview(orLine)
        orLine.anchor(top: forgotPasswordStack.bottomAnchor, paddingTop: 32,
                      leading: view.leadingAnchor, paddingLeft: 48,
                      trailing: view.trailingAnchor, paddingRight: -48)
        
        let logInWithGoogleStack = UIUtilities.additionalStackWithImageView(withImage: UIImage(named: K.ImageName.googleLogo)!, imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithGoogleButton)
        view.addSubview(logInWithGoogleStack)
        logInWithGoogleStack.centerX(inView: view, topAnchor: orLine.bottomAnchor, paddingTop: 32)
        
        let logInWithAppleStack = UIUtilities.additionalStackWithImageView(withImage: UIImage(named: K.ImageName.appleLogo)!, imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithAppleButton)
        view.addSubview(logInWithAppleStack)
        logInWithAppleStack.centerX(inView: view, topAnchor: logInWithGoogleStack.bottomAnchor, paddingTop: 24)
       
        let toSignUpStack = UIUtilities.additionalStackWithLabel(withLabelText: K.AccountScreensText.LabelText.dontHaveAccount, withTextSize: view.frame.height/50, button: toSignUpButton)
        view.addSubview(toSignUpStack)
        toSignUpStack.centerX(inView: view, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -16)
    }
}
