//
//  Router.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

import UIKit

class Router: NSObject {
    
    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: RouterProtocol {
    
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popToRootViewController(animated: isAnimated)
    }
    
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        navigationController.present(viewController, animated: isAnimated, completion: nil)
        viewController.presentationController?.delegate = self
    }
    
    //To tab bar
    func viewControllers(controllers drawables: [Drawable]) {
        var viewControllers = [UIViewController]()
        drawables.forEach { (drawable) in
            guard let viewController = drawable.viewController else { return }
            viewControllers.append(viewController)
        }
        navigationController.viewControllers = viewControllers
    }
}

extension Router: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(presentationController.presentedViewController)
    }
}

extension Router : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
