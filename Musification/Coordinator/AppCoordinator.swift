//
//  AppCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    private let navigationController: UINavigationController = {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        return navController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: self.navigationController)
        
        showLoginFlow(router: router)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

//MARK: - Navigation Flow
private extension AppCoordinator {
    func showLoginFlow(router: Router) {
        let coordinator = LoginCoordinator(router: router)
        self.add(coordinator: coordinator)
        
        coordinator.start()
    }
    
    func showMainFlow(router: Router) {
        let coordinator = TabCoordinator.init(router: router)
        self.add(coordinator: coordinator)
        
        coordinator.start()
    }
}
