//
//  SongsCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class SongsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .songs }

    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let view = SongsViewController()
        let viewModel = SongsViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension SongsCoordinator {
    func moveScreenLogic(viewModel: SongsViewModel) {
        
    }
}

//MARK: - Navigation Flow
private extension SongsCoordinator {
    
}


