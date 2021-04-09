//
//  SongsCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class SongsCoordinator: BaseCoordinator {
        
    private let disposeBag = DisposeBag()
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        let view = SongsViewController()
        
        router.push(view, isAnimated: true, onNavigateBack: nil)
    }
}


