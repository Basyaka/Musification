//
//  ArtistsCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 9.04.21.
//

import RxSwift

class ArtistsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .artists }

    private let disposeBag = DisposeBag()

    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func start() {
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
