//
//  LoginViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxGesture
import GoogleSignIn
import JGProgressHUD

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let presentationView = UIView()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        let image = R.image.musification()!
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
        let view = UIUtilities.inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.passwordContainerView)
        let view = UIUtilities.inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private let logInButton: UIButton = {
        let bt = UIUtilities.mainButton(withTitle: R.string.localizable.logIn())
        return bt
    }()
    
    private let loginHUD: JGProgressHUD = {
        let hud = JGProgressHUD()
        hud.textLabel.text = "Login..."
        hud.style = .light
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    private lazy var passwordRecoveryButton: UIButton = {
        let bt = UIUtilities.attributedButton(R.string.localizable.forgotYourPassword(), R.string.localizable.getHelpSigningIn(), withTextSize: view.frame.height/50)
        return bt
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let bt = UIUtilities.attributedButton(R.string.localizable.dontHaveAnAccount(), R.string.localizable.signUp(), withTextSize: view.frame.height/50)
        return bt
    }()
    
    //MARK: - !!!
    private lazy var logInWithGoogleButton: UIButton = {
        //Custom Button
        let bt = UIUtilities.additionalButton(withText: R.string.localizable.logInWithGoogle(), withTextSize: view.frame.height/40)
        
        //        let bt = GIDSignInButton()
        
        return bt
    }()
    
    var input: LoginViewModel.Input {
        return LoginViewModel.Input(
            emailTextDriver: emailTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            passwordTextDriver: passwordTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            signUpTapControlEvent: dontHaveAccountButton.rx.tap,
            passwordRecoveryTapControlEvent: passwordRecoveryButton.rx.tap,
            loginButtonTapControlEvent: logInButton.rx.tap
        )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    
    //MARK: - Helpers functions
    private func bind(output: LoginViewModel.Output) {
        //Button enabled
        output.isButtonEnabled
            .drive(logInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isButtonEnabled
            .map { $0 ? 1 : 0.1 }
            .drive(logInButton.rx.alpha)
            .disposed(by: disposeBag)
        
        //Progress view show
        output.loginButtonTapControlEvent.subscribe(onNext: {
            self.loginHUD.show(in: self.view, animated: true)
        }).disposed(by: disposeBag)
        
        //Progress view dissmiss
        output.successLoginResponseObservable.subscribe(onNext: {
            self.loginHUD.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        output.failureLoginResponseObservable.subscribe(onNext: {
            self.loginHUD.dismiss(animated: true)
            //Present error ...
            self.showErrorAlert()
        }).disposed(by: disposeBag)
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
        
        presentationView.addSubview(logoImageView)
        logoImageView.centerX(inView: presentationView, topAnchor: presentationView.topAnchor)
        logoImageView.setDimensions(width: view.frame.width/2, height: view.frame.height/5)
        
        let mainStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, logInButton])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        presentationView.addSubview(mainStack)
        mainStack.anchor(top: logoImageView.bottomAnchor,
                         leading: presentationView.leadingAnchor, paddingLeft: 32,
                         trailing: presentationView.trailingAnchor, paddingRight: -32)
        
        presentationView.addSubview(passwordRecoveryButton)
        passwordRecoveryButton.anchor(top: mainStack.bottomAnchor, paddingTop: 24,
                                      leading: presentationView.leadingAnchor, paddingLeft: 32,
                                      trailing: presentationView.trailingAnchor, paddingRight: -32)
        
        let orLine = UIUtilities.orLine(withText: R.string.localizable.oR())
        presentationView.addSubview(orLine)
        orLine.anchor(top: passwordRecoveryButton.bottomAnchor, paddingTop: 32,
                      leading: presentationView.leadingAnchor, paddingLeft: 48,
                      trailing: presentationView.trailingAnchor, paddingRight: -48)
        
        //MARK: - !!!
        //MARK: - Custom stack with image
        let logInWithGoogleStack = UIUtilities.additionalStackWithImageView(withImage: R.image.googleLogo()! , imageWidth: view.frame.height/30, imageHeight: view.frame.height/30, button: logInWithGoogleButton)
        presentationView.addSubview(logInWithGoogleStack)
        logInWithGoogleStack.centerX(inView: presentationView, topAnchor: orLine.bottomAnchor, paddingTop: 32)
        //        logInWithGoogleButton.anchor(top: orLine.bottomAnchor, paddingTop: 32,
        //                                     leading: presentationView.leadingAnchor, paddingLeft: 32,
        //                                     trailing: presentationView.trailingAnchor, paddingRight: -32)
        
        presentationView.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(bottom: presentationView.bottomAnchor, paddingBottom: -16,
                                     leading: presentationView.leadingAnchor, paddingLeft: 32,
                                     trailing: presentationView.trailingAnchor, paddingRight: -32)
    }
}

//MARK: - Login Error
private extension LoginViewController {
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "LoginError", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
