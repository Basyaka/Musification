//
//  PasswordRecoveryCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class PasswordRecoveryCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = PasswordRecoveryViewController()
        let viewModel = PasswordRecoveryViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: isCompeted)
        
        //Back to login
        viewModel.backTapPublishSubject.subscribe(onNext: {_ in
            self.router.pop(true)
        }).disposed(by: disposeBag)
        
        viewModel.backSwipePublishSubject.subscribe(onNext: {_ in
            self.router.pop(true)
        }).disposed(by: disposeBag)
        
    }
}
