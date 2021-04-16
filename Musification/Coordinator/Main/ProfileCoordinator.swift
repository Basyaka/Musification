//
//  ProfileCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class ProfileCoordinator: Coordinator {
    
    private let disposeBag = DisposeBag()
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .profile }
    
    private let router: RouterProtocol
    
    let finishMainFlowPublishSubject = PublishSubject<Void>()
        
    required init(_ router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = ProfileViewController()
        let viewModel = ProfileViewModel()
        let firebaseService = FirebaseService()
        viewModel.firebaseService = firebaseService
        view.viewModel = viewModel
        
        //User Info request logic
        view.startSpinner()
        firebaseService.getUserInfo()
        
        router.push(view, isAnimated: false, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension ProfileCoordinator {
    func moveScreenLogic(viewModel: ProfileViewModel) {
        //Log Out: Event -> Event to TabController
        viewModel.signOutEventPublishSubject.subscribe(onNext: {
            self.finishMainFlowPublishSubject.onNext($0)
        }).disposed(by: disposeBag)
    }
}
