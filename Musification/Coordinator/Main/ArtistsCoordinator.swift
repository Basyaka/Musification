//
//  ArtistsCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class ArtistsCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = ArtistsViewController()
        let viewModel = ArtistsViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension ArtistsCoordinator {
    func moveScreenLogic(viewModel: ArtistsViewModel) {
        
    }
}

//MARK: - Navigation Flow
private extension ArtistsCoordinator {
    
}
