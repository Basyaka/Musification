//
//  BaseCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompeted: (() -> ())?
    
    func start() {
        fatalError("Children should implement 'start'.")
    }
}
