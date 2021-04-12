//
//  LoginCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class LoginCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
    
    private var router: RouterProtocol
    
    init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = LoginViewController()
        let viewModel = LoginViewModel()
        viewModel.firebaseService = FirebaseService()
        viewModel.model = FirebaseAuthModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: false, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
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
            self.finish()
        }).disposed(by: disposeBag)
    }
}

//MARK: - Navigation Flow
private extension LoginCoordinator {
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
}
