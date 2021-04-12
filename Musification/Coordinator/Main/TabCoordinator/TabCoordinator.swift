//
//  TabCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit
import RxSwift

protocol TabCoordinatorProtocol: BaseCoordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    
    private let disposeBag = DisposeBag()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    private var router: RouterProtocol
    
    var tabBarController: UITabBarController
    
    var type: CoordinatorType { .tab }
    
    required init(_ router: RouterProtocol) {
        self.router = router
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.songs, .artists, .albums, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        /// Set delegate for UITabBarController
        tabBarController.delegate = self
        /// Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        /// Let set index
        tabBarController.selectedIndex = TabBarPage.songs.pageOrderNumber()
        /// Styling
        tabBarController.tabBar.isTranslucent = false
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        router.viewControllers(controllers: [tabBarController])
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        //Nav controller
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        //Create router
        let TabBarRouter = Router(navigationController: navController)
        
        //Set BarItem settings
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIconValue(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .songs:
            showSongsFlow(router: TabBarRouter)
            
        case .artists:
            showArtistsFlow(router: TabBarRouter)
            
        case .albums:
            showAlbumsFlow(router: TabBarRouter)
            
        case .profile:
            showProfileFlow(router: TabBarRouter)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

//MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}

//MARK: - Navigation Flow
private extension TabCoordinator {
    func showSongsFlow(router: Router) {
        let coordinator = SongsCoordinator(router: router)
        self.add(coordinator: coordinator)
        coordinator.start()
    }
    
    func showArtistsFlow(router: Router) {
        let coordinator = ArtistsCoordinator(router: router)
        self.add(coordinator: coordinator)
        coordinator.start()
    }
    
    func showAlbumsFlow(router: Router) {
        let coordinator = AlbumsCoordinator(router: router)
        self.add(coordinator: coordinator)
        coordinator.start()
    }
    
    func showProfileFlow(router: Router) {
        let coordinator = ProfileCoordinator(router)
        self.add(coordinator: coordinator)
        coordinator.start()
        coordinator.signOutTapPublishSubject.subscribe(onNext: {
            self.finish()
        }).disposed(by: disposeBag)
    }
}
