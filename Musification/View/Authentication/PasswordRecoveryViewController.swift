//
//  PasswordRecoveryViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit
import RxSwift
import RxCocoa

class PasswordRecoveryViewController: UIViewController {
    
    var viewModel: PasswordRecoveryViewModel!
    private let bag = DisposeBag()
    
    //MARK: - Properties
    private let backButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(systemName: K.SystemImageName.backButton), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    private let swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        return swipe
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.musification()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.email())
    private let resetButton = UIUtilities.mainButton(withTitle: R.string.localizable.sendResetLink())
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.emailTextContainerView)
        let view = UIUtilities.inputContainerView1(withImage: image!, textField: emailTextField)
        return view
    }()
    
    var input: PasswordRecoveryViewModel.Input {
        return PasswordRecoveryViewModel.Input(
            emailTextDriver: emailTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            backTap: backButton.rx.tap.asDriver(),
            backSwipe: swipeRight.rx.event.asDriver()
        )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func configureController() {
        view.addGestureRecognizer(swipeRight)
        configureGradientBackground()
        setLayout()
    }
    
    private func bind(output: PasswordRecoveryViewModel.Output) {
        output.isButtonEnabled
            .drive(resetButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.isButtonEnabled
            .map { $0 ? 1 : 0.1 }
            .drive(resetButton.rx.alpha)
            .disposed(by: bag)
    }
    
    private func setLayout() {
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16,
                          leading: view.leadingAnchor, paddingLeft: 16,
                          width: 25, height: 25)
        
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

