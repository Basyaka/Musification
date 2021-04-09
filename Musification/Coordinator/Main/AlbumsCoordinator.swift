//
//  AlbumsCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class AlbumsCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = AlbumsViewController()
        let viewModel = AlbumsViewModel()
        view.viewModel = viewModel
        
        router.push(view, isAnimated: true, onNavigateBack: nil)
        
        moveScreenLogic(viewModel: viewModel)
    }
}

//MARK: - Move Screen Logic
private extension AlbumsCoordinator {
    func moveScreenLogic(viewModel: AlbumsViewModel) {
        
    }
}

//MARK: - Navigation Flow
private extension AlbumsCoordinator {
    
}
