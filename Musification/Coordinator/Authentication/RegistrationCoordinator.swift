//
//  RegistrationCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import RxSwift

class RegistrationCoordinator: BaseCoordinator {
    
    private let bag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = RegistrationViewController()
        let viewModel = RegistrationViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: isCompeted)
        
        //Back to login
        viewModel.haveAccountTapPublishSubject.subscribe(onNext: {
            self.router.pop(true)
        }).disposed(by: bag)
    }
}
