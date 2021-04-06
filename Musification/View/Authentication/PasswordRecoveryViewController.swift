//
//  PasswordRecoveryViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

class PasswordRecoveryViewController: UIViewController {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: K.ImageName.musificationLogo)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: K.PlaceholderText.email)
    private let resetButton = UIUtilities.mainButton(withTitle: K.AuthenticationScreensText.ButtonText.resetButton)
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.emailTextContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: emailTextField)
        return view
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    //MARK: - Helpers functions
    private func configureController() {
        configureGradientBackground()
        setupNavigationBarItem()
        setLayout()
    }
    
    private func setupNavigationBarItem() {
    }
    
    private func setLayout() {
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: view.frame.width/2, height: view.frame.height/5)
        
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                       resetButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        view.addSubview(mainStack)
        mainStack.anchor(top: logoImageView.bottomAnchor,
                         leading: view.leadingAnchor, paddingLeft: 32,
                         trailing: view.trailingAnchor, paddingRight: -32)
    }
}

