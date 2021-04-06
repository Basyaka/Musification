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
        iv.image = R.image.musification()!
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.email())
    
    private let passwordTextField: UITextField = {
        let tf = UIUtilities.textField(withPlaceholder: R.string.localizable.password())
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
    
    private let logInButton: UIButton = {
        let bt = UIUtilities.mainButton(withTitle: R.string.localizable.logIn())
        return bt
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let bt = UIUtilities.attributedButton(R.string.localizable.forgotYourPassword(), R.string.localizable.getHelpSigningIn(), withTextSize: view.frame.height/50)
        bt.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let bt = UIUtilities.attributedButton(R.string.localizable.dontHaveAnAccount(), R.string.localizable.signUp(), withTextSize: view.frame.height/50)
        
        bt.addTarget(self, action: #selector(dontHaveAccountButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var logInWithGoogleButton: UIButton = {
        let bt = UIUtilities.additionalButton(withText: R.string.localizable.logInWithGoogle(), withTextSize: view.frame.height/40)
        return bt
    }()
    
    private lazy var logInWithAppleButton: UIButton = {
        let bt = UIUtilities.additionalButton(withText: R.string.localizable.logInWithApple(), withTextSize: view.frame.height/40)
        return bt
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        
    }
    
    //MARK: - Selectors
    @objc private func forgotPasswordButtonTapped() {
        navigationController?.pushViewController(PasswordRecoveryViewController(), animated: true)
    }
    
    @objc private func dontHaveAccountButtonTapped() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
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
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top: mainStack.bottomAnchor, paddingTop: 24,
                                   leading: view.leadingAnchor, paddingLeft: 32,
                                   trailing: view.trailingAnchor, paddingRight: -32)
        
        let orLine = UIUtilities.orLine(withText: R.string.localizable.oR())
        view.addSubview(orLine)
        orLine.anchor(top: forgotPasswordButton.bottomAnchor, paddingTop: 32,
                      leading: view.leadingAnchor, paddingLeft: 48,
                      trailing: view.trailingAnchor, paddingRight: -48)
        
        let logInWithGoogleStack = UIUtilities.additionalStackWithImageView(withImage: R.image.googleLogo()! , imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithGoogleButton)
        view.addSubview(logInWithGoogleStack)
        logInWithGoogleStack.centerX(inView: view, topAnchor: orLine.bottomAnchor, paddingTop: 32)
        
        let logInWithAppleStack = UIUtilities.additionalStackWithImageView(withImage: R.image.appleLogo()!, imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithAppleButton)
        view.addSubview(logInWithAppleStack)
        logInWithAppleStack.centerX(inView: view, topAnchor: logInWithGoogleStack.bottomAnchor, paddingTop: 24)
       
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -16,
                             leading: view.leadingAnchor, paddingLeft: 32,
                             trailing: view.trailingAnchor, paddingRight: -32)
    }
}
