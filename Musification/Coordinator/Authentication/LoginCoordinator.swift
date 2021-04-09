//
//  LoginCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class LoginCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = LoginViewController()
        let viewModel = LoginViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: false, onNavigateBack: isCompeted)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

private extension LoginCoordinator {
    func moveScreenLogic(viewModel: LoginViewModel) {
        //Tap to Registration
        viewModel.signUpTapPublishSubject.subscribe(onNext: {
            self.showRegistration()
        }).disposed(by: disposeBag)
        
        //Tap to PasswordRecovery
        viewModel.passwordRecoveryTapPublishSubject.subscribe(onNext: {
            self.showPasswordRecovery()
        }).disposed(by: disposeBag)
        
        //Tap to TabBar
        viewModel.loginInTapPublishSubject.subscribe(onNext: {
            self.showTabBar()
        }).disposed(by: disposeBag)
    }
    
    func showRegistration() {
        let coordinator = RegistrationCoordinator(router: router)
        add(coordinator: coordinator)
        
        coordinator.isCompeted = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        coordinator.start()
    }
    
    func showPasswordRecovery() {
        let coordinator = PasswordRecoveryCoordinator(router: router)
        add(coordinator: coordinator)
        
        coordinator.isCompeted = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        coordinator.start()
    }
    
    func showTabBar() {
        let coordinator = TabCoordinator(router: router)
        add(coordinator: coordinator)
        finish()
        coordinator.start()
    }
}
