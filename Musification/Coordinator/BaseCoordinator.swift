//
//  BaseCoordinator.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import UIKit

class BaseCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompeted: (() -> ())?
    
    func start() {
        fatalError("Children should implement 'start'.")
    }
}
