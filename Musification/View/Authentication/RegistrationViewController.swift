//
//  RegistrationViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture

class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel!
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let presentationView = UIView()
    
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
            haveAccountTapControlEvent: haveAccountButton.rx.tap,
            registrationButtonTapControlEvent: signUpButton.rx.tap
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
            .disposed(by: disposeBag)
        
        output.isButtonEnabled
            .map { $0 ? 1 : 0.1 }
            .drive(signUpButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func configureController() {
        configureGradientBackground()
        setGestures()
        setKeyboardNotifications()
        setLayout()
    }
    
    private func setGestures() {
        presentationView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [self] _ in
                presentationView.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    private func setKeyboardNotifications() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [scrollView] keyboardVisibleHeight in
                scrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          leading: view.safeAreaLayoutGuide.leadingAnchor,
                          trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        scrollView.addSubview(presentationView)
        presentationView.anchor(top: scrollView.contentLayoutGuide.topAnchor,
                                bottom: scrollView.contentLayoutGuide.bottomAnchor,
                                leading: scrollView.contentLayoutGuide.leadingAnchor,
                                trailing: scrollView.contentLayoutGuide.trailingAnchor)
        presentationView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
        presentationView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        presentationView.addSubview(photoButton)
        photoButton.setDimensions(width: view.frame.width/3, height: view.frame.width/3)
        photoButton.centerX(inView: presentationView, topAnchor: presentationView.topAnchor, paddingTop: 16)
        
        presentationView.addSubview(photoImage)
        photoImage.setDimensions(width: view.frame.width/3, height: view.frame.width/3)
        photoImage.centerX(inView: presentationView, topAnchor: presentationView.topAnchor, paddingTop: 16)
        
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView,
                                                       passwordContainerView,
                                                       fullNameContainerView,
                                                       usernameContainerView,
                                                       signUpButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        presentationView.addSubview(mainStack)
        mainStack.anchor(top: photoImage.bottomAnchor, paddingTop: 32,
                         leading: presentationView.leadingAnchor, paddingLeft: 32,
                         trailing: presentationView.trailingAnchor, paddingRight: -32)
        
        presentationView.addSubview(haveAccountButton)
        haveAccountButton.anchor(bottom: presentationView.bottomAnchor, paddingBottom: -16,
                                 leading: presentationView.leadingAnchor, paddingLeft: 32,
                                 trailing: presentationView.trailingAnchor, paddingRight: -32)
    }
}
