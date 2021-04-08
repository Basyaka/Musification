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
        
    func showLoginFlow(router: Router) {
        let loginCoordinator = LoginCoordinator(router: router)
        self.add(coordinator: loginCoordinator)
        
        loginCoordinator.start()
    }
    
    func showMainFlow(router: Router) {
        let tabCoordinator = TabCoordinator.init(router: router)
        self.add(coordinator: tabCoordinator)
        
        tabCoordinator.start()
    }
}
