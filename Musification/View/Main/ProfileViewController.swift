//
//  ProfileViewController.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel!
    
    private let disposeBag = DisposeBag()
    
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
        lb.text = "Username"
        lb.font = UIFont.systemFont(ofSize: view.frame.height/25, weight: .bold)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    private let logOutButton = UIUtilities.mainButton(withTitle: R.string.localizable.logOut())
    
    var input: ProfileViewModel.Input {
        return ProfileViewModel.Input(
            signOutTapControlEvent: logOutButton.rx.tap
            )
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        bind(output: viewModel.transform(input))
    }
    
    //MARK: - Helpers functions
    private func bind(output: ProfileViewModel.Output) {}
    
    private func configureController() {
        configureGradientBackground()
        setLayout()
    }
    
    private func setLayout() {
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        profileImageView.setDimensions(width: view.frame.height/5, height: view.frame.height/5)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        
        view.addSubview(logOutButton)
        logOutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: -56,
                            leading: view.safeAreaLayoutGuide.leadingAnchor, paddingLeft: 32,
                            trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingRight: -32)
        
    }
}





