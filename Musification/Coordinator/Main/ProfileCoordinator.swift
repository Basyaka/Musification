//
//  ProfileCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class ProfileCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = ProfileViewController()
        let viewModel = ProfileViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension ProfileCoordinator {
    func moveScreenLogic(viewModel: ProfileViewModel) {
        
    }
}

//MARK: - Navigation Flow
private extension ProfileCoordinator {
    
}
