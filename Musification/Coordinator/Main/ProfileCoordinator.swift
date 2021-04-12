//
//  ProfileCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .profile }
    
    private let disposeBag = DisposeBag()
    
    let signOutTapPublishSubject = PublishSubject<Void>()
    
    private let router: RouterProtocol
        
    required init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = ProfileViewController()
        let viewModel = ProfileViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: false, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension ProfileCoordinator {
    func moveScreenLogic(viewModel: ProfileViewModel) {
        viewModel.signOutTapPublishSubject.subscribe(onNext: {
            self.signOutTapPublishSubject.onNext($0)
        }).disposed(by: disposeBag)
    }
}
