//
//  Router+Protocol.swift
//  Musification
//
//  Created by Vlad Novik on 7.04.21.
//

typealias NavigationBackClosure = (() -> ())

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?)
    func viewControllers(controllers drawables: [Drawable])
}
