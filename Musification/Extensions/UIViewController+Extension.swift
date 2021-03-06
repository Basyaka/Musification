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

//MARK: - Activity Indicator
fileprivate var aView: UIView?

extension UIViewController {
    
    func startSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .systemBackground
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
