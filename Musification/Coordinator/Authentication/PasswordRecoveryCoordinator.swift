//
//  PasswordRecoveryCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class PasswordRecoveryCoordinator: Coordinator {
    
    private let disposeBag = DisposeBag()
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .passwordRecovery }

    private let router: RouterProtocol
    
    var isCompleted: (() -> ())?

    init(router: RouterProtocol) {
        self.router = router
    }

    func start() {
        let view = PasswordRecoveryViewController()
        let viewModel = PasswordRecoveryViewModel()
        view.viewModel = viewModel

        router.push(view, isAnimated: true, onNavigateBack: isCompleted)

        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension PasswordRecoveryCoordinator {
    func moveScreenLogic(viewModel: PasswordRecoveryViewModel) {
        //Back to login with button
        viewModel.backTapPublishSubject.subscribe(onNext: {_ in
            self.router.pop(true)
        }).disposed(by: disposeBag)

        //Back to login with right swipe
        viewModel.backSwipePublishSubject.subscribe(onNext: {_ in
            self.router.pop(true)
        }).disposed(by: disposeBag)
    }
}
