//
//  RegistrationViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Properties
    private let photoButton: UIButton = {
        let bt = UIButton()
        return bt
    }()
    
    private let photoImage: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: K.SystemImageName.addPhoto)
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: K.PlaceholderText.email)
    
    private let passwordTextField: UITextField = {
        let tf = UIUtilities.textField(withPlaceholder: K.PlaceholderText.password)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = UIUtilities.textField(withPlaceholder: K.PlaceholderText.fullName)
    private let usernameTextField = UIUtilities.textField(withPlaceholder: K.PlaceholderText.username)
    private let signUpButton = UIUtilities.mainButton(withTitle: K.AccountScreensText.ButtonText.signUp)
    
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
    
    private lazy var fullNameContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.fullNameContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: fullNameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.usernameContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: usernameTextField)
        return view
    }()
    
    private lazy var haveAccountButton = UIUtilities.additionalButton(withText: K.AccountScreensText.ButtonText.logIn, withTextSize: view.frame.height/50)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    //MARK: - Helpers functions
    private func configureController() {
        configureGradientBackground()
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(photoButton)
        photoButton.setDimensions(width: view.frame.width/3, height: view.frame.width/3)
        photoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        
        view.addSubview(photoImage)
        photoImage.setDimensions(width: view.frame.width/3, height: view.frame.width/3)
        photoImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        view.addSubview(mainStack)
        mainStack.anchor(top: photoImage.bottomAnchor, paddingTop: 32,
                     leading: view.leadingAnchor, paddingLeft: 32,
                     trailing: view.trailingAnchor, paddingRight: -32)
        
        let haveAccountStack = UIUtilities.additionalStackWithLabel(withLabelText: K.AccountScreensText.LabelText.haveAccount, withTextSize: view.frame.height/50, button: haveAccountButton)
        haveAccountStack.spacing = 3
        view.addSubview(haveAccountStack)
        haveAccountStack.centerX(inView: view, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -16)
    }
}
