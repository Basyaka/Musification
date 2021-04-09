//
//  RegistrationCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class RegistrationCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = RegistrationViewController()
        let viewModel = RegistrationViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: isCompeted)
        moveScreenLogic(viewModel: viewModel)
    }
}

private extension RegistrationCoordinator {
    func moveScreenLogic(viewModel: RegistrationViewModel) {
        //Back to login
        viewModel.haveAccountTapPublishSubject.subscribe(onNext: {
            self.router.pop(true)
        }).disposed(by: disposeBag)
        
        //Tap to TabBar
        viewModel.registrationButtonTapPublishSubject.subscribe(onNext: {
            self.showTabBar()
        }).disposed(by: disposeBag)

    }
    
    func showTabBar() {
        let coordinator = TabCoordinator(router: router)
        add(coordinator: coordinator)
        finish()
        coordinator.start()
    }
}
