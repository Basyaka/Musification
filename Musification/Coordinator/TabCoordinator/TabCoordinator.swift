//
//  TabCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit

protocol TabCoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: BaseCoordinator, TabCoordinatorProtocol {
    
    private let router: RouterProtocol
    
    var tabBarController: UITabBarController
    
    init(router: RouterProtocol) {
        self.router = router
        self.tabBarController = .init()
    }
    
    override func start() {
        let pages: [TabBarPage] = [.songs, .artists, .profile]
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
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .songs:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let songsVC = SongsViewController()
            songsVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .songs:
                    self?.selectPage(.songs)
                }
            }
            
            navController.pushViewController(songsVC, animated: true)
            
        case .artists:
            let artistsVC = ArtistsViewController()
            artistsVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .artists:
                    self?.selectPage(.artists)
                }
            }
            
            navController.pushViewController(artistsVC, animated: true)
            
        case .profile:
            let profileVC = ProfileViewController()
            profileVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .profile:
                    self?.selectPage(.profile)                }
            }
            navController.pushViewController(profileVC, animated: true)
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
