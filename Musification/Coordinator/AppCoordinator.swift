//
//  AppCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import FirebaseAuth

protocol AppCoordinatorProtocol: RootCoordinator {
    func showLoginFlow()
    func showMainFlow()
}

class AppCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var router: RouterProtocol
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        if Auth.auth().currentUser?.uid == nil {
            showLoginFlow()
        } else {
            showMainFlow()
        }
    }
}

//MARK: - Navigation Flow
extension AppCoordinator: AppCoordinatorProtocol {
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(router)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        add(coordinator: loginCoordinator)
    }
    
    func showMainFlow() {
        let tabCoordinator = TabCoordinator(router)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        add(coordinator: tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            router.removeAllViewControllers()
            
            showLoginFlow()
            
        case .login:
            router.removeAllViewControllers()
            
            showMainFlow()
            
        default:
            break
        }
    }
}
