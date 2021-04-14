//
//  ProfileViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel!
    
    private let disposeBag = DisposeBag()
    
    private let confirmedSignOutPublishSubject = PublishSubject<Void>()
    
    private let relayEvent: () = PublishRelay<Void>.Element()
    
    //MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.profileimage()
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.layer.masksToBounds = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = (view.frame.height/5) / 2
        return iv
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: view.frame.height/25, weight: .bold)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    private let signOutButton: UIButton = {
        let bt = UIUtilities.mainButton(withTitle: R.string.localizable.signOut())
        return bt
    }()
    
    var input: ProfileViewModel.Input {
        return ProfileViewModel.Input(
            confiredSignOutDriver: confirmedSignOutPublishSubject.asDriver(onErrorJustReturn: ())
        )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: ProfileViewModel.Output) {
        output.usernameTextDriver
            .drive(usernameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func configureController() {
        setActions()
        configureGradientBackground()
        setLayout()
    }
    
    private func setLayout() {
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        profileImageView.setDimensions(width: view.frame.height/5, height: view.frame.height/5)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
        
        view.addSubview(signOutButton)
        signOutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -56,
                             leading: view.safeAreaLayoutGuide.leadingAnchor, paddingLeft: 32,
                             trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingRight: -32)
        
    }
}

//MARK: - UI Actions
private extension ProfileViewController {
    func setActions() {
        subsribeToSignOutButton()
    }
    
    func subsribeToSignOutButton() {
        signOutButton.rx.tap.subscribe(onNext: {
            self.showActionSheet()
        }).disposed(by: disposeBag)
    }
}

//MARK: - Presentation UI
private extension ProfileViewController {
    func showActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.signOut(), style: .destructive, handler: { _ in
            self.confirmedSignOutPublishSubject.onNext(PublishSubject<Void>.Element())
        }))
        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}





