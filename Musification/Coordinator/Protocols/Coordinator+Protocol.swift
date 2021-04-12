//
//  Coordinator+Protocol.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

protocol Coordinator: class {
    /// Array to keep tracking of all child coordinators. Most of the time this array will contain only one child coordinator
    var childCoordinators: [Coordinator] { get set }
    /// Defined flow type.
    var type: CoordinatorType { get }
    /// A place to put logic to start the flow.
    func start()
}

protocol BaseCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    /// A place to put logic to finish the flow, to clean all children coordinators, and to notify the parent that this coordinator is ready to be deallocated
    func finish()
    
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter ({ $0 !== coordinator })
    }
}

extension BaseCoordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - CoordinatorOutput
/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType
/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorType {
    case app
    case login, tab
    case registration, passwordRecovery
    case songs, artists, albums, profile
}

