//
//  RegistrationViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel!
    private let bag = DisposeBag()
    
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
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.email())
    
    private let passwordTextField: UITextField = {
        let tf = UIUtilities.textField(withPlaceholder: R.string.localizable.password())
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.fullName())
    private let usernameTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.username())
    
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
    
    private let signUpButton = UIUtilities.mainButton(withTitle: R.string.localizable.signUp())
    
    private lazy var haveAccountButton: UIButton = {
        let bt = UIUtilities.attributedButton(R.string.localizable.alreadyHaveAnAccount(), R.string.localizable.logIn(), withTextSize: view.frame.height/50)
        return bt
    }()
    
    var input: RegistrationViewModel.Input {
        return RegistrationViewModel.Input(
            emailTextDriver: emailTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            passwordTextDriver: passwordTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            fullNameTextDriver: fullNameTextField.rx.text.map {$0 ?? ""}.asDriver(onErrorJustReturn: ""),
            usernameTextDriver: usernameTextField.rx.text.map {$0 ?? ""}.asDriver(onErrorJustReturn: ""),
            haveAccountTapDriver: haveAccountButton.rx.tap.asDriver()
        )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: RegistrationViewModel.Output) {
        output.isButtonEnabled
            .drive(signUpButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.isButtonEnabled
            .map { $0 ? 1 : 0.1 }
            .drive(signUpButton.rx.alpha)
            .disposed(by: bag)
    }
    
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
        
        view.addSubview(haveAccountButton)
        haveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -16,
                                 leading: view.leadingAnchor, paddingLeft: 32,
                                 trailing: view.trailingAnchor, paddingRight: -32)
    }
}
