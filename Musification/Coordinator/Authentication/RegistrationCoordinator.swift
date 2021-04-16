//
//  RegistrationCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import UIKit
import RxSwift

class RegistrationCoordinator: RootCoordinator {
    
    private let disposeBag = DisposeBag()
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .registration }
    
    private var router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = RegistrationViewController()
        let viewModel = RegistrationViewModel()
        viewModel.firebaseService = FirebaseService()
        viewModel.model = FirebaseAuthModel()
        view.viewModel = viewModel

        router.push(view, isAnimated: false, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension RegistrationCoordinator {
    func moveScreenLogic(viewModel: RegistrationViewModel) {
        //Tap to login
        viewModel.haveAccountTapPublishSubject.subscribe(onNext: {
            self.finish()
        }).disposed(by: disposeBag)

        //Tap to TabBar
        viewModel.registrationButtonTapPublishSubject.subscribe(onNext: {
            self.finish()
        }).disposed(by: disposeBag)
    }
}

