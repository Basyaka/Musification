//
//  UIViewController+Extension.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

//MARK: - Configure Background Gradient
extension UIViewController {
  func configureGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemGray.cgColor, UIColor.systemRed.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
}

//MARK: - Drawable
extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
