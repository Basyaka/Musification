//
//  PasswordRecoveryViewController.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class PasswordRecoveryViewController: UIViewController {
    
    var viewModel: PasswordRecoveryViewModel!
    private let disposeBag = DisposeBag()
    
    //MARK: - Properties
    private let backButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(systemName: K.SystemImageName.backButton), for: .normal)
        bt.tintColor = .white
        return bt
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.musificationLogo()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let emailTextField = UIUtilities.textField(withPlaceholder: R.string.localizable.email())
    private let resetButton = UIUtilities.mainButton(withTitle: R.string.localizable.sendResetLink())
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: K.SystemImageName.emailTextContainerView)
        let view = UIUtilities.inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    var input: PasswordRecoveryViewModel.Input {
        return PasswordRecoveryViewModel.Input(
            emailTextDriver: emailTextField.rx.text.map { $0 ?? "" }.asDriver(onErrorJustReturn: ""),
            backTap: backButton.rx.tap.asDriver(),
            backSwipe: view.rx.swipeGesture(.right)
        )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: PasswordRecoveryViewModel.Output) {
        output.isButtonEnabled
            .drive(resetButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isButtonEnabled
            .map { $0 ? 1 : 0.1 }
            .drive(resetButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func configureController() {
        configureGradientBackground()
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16,
                          leading: view.safeAreaLayoutGuide.leadingAnchor, paddingLeft: 16,
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
                         leading: view.safeAreaLayoutGuide.leadingAnchor, paddingLeft: 32,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingRight: -32)
    }
}

