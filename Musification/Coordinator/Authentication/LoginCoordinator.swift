//
//  LoginCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class LoginCoordinator: BaseCoordinator {
    
    private let bag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = LoginViewController()
        let viewModel = LoginViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: false, onNavigateBack: isCompeted)
        
        //Tap to Registration
        viewModel.signUpTapPublishSubject.subscribe(onNext: {
            self.showRegistration()
        }).disposed(by: bag)
        
        //Tap to PasswordRecovery
        viewModel.passwordRecoveryTap.subscribe(onNext: {
            self.showPasswordRecovery()
        }).disposed(by: bag)
    }
}

private extension LoginCoordinator {
    func showRegistration() -> Void {
        let coordinator = RegistrationCoordinator(router: router)
        add(coordinator: coordinator)
        
        coordinator.isCompeted = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        coordinator.start()
    }
    
    func showPasswordRecovery() -> Void {
        let coordinator = PasswordRecoveryCoordinator(router: router)
        add(coordinator: coordinator)
        
        coordinator.isCompeted = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.remove(coordinator: coordinator)
        }
        coordinator.start()
    }
}
