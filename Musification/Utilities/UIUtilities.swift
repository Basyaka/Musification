//
//  UIUtilities.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

class UIUtilities {
    
    static func inputContainerView1(withImage image: UIImage, textField: UITextField) -> UIView {
        
        let view = UIView()
        view.tintColor = .white
        view.setHeight(height: 50)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(bottom: view.bottomAnchor,
                           leading: view.leadingAnchor, paddingLeft: 8,
                           trailing: view.trailingAnchor, paddingRight: -8,
                           height: 0.75)
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, paddingTop: 16,
                         bottom: dividerView.topAnchor, paddingBottom: -4,
                         leading: view.leadingAnchor, paddingLeft: 8,
                         width: 24)
        
        view.addSubview(textField)
        textField.anchor(top: view.topAnchor, paddingTop: 16,
                         bottom: dividerView.topAnchor,
                         leading: imageView.trailingAnchor, paddingLeft: 8,
                         trailing: view.trailingAnchor, paddingRight: -8)
        return view
    }
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.textColor = .white
        tf.placeholder = placeholder
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        return tf
    }
    
    static func mainButton(withTitle title: String) -> UIButton {
        let bt = UIButton()
        bt.setTitle(title, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt.titleLabel?.textColor = .white
        bt.layer.cornerRadius = 5
        bt.backgroundColor = .darkRed
        bt.setHeight(height: 50)
        return bt
    }
    
    static func additionalStackWithImageView(withImage image: UIImage, imageWidth width: CGFloat, imageHeight height: CGFloat, button: UIButton) -> UIStackView {
        let iv = UIImageView()
        iv.image = image
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(width: width, height: height)
        
        let stack = UIStackView(arrangedSubviews: [iv, button])
        stack.spacing = 5
        return stack
    }
    
    static func additionalButton(withText title: String, withTextSize size: CGFloat) -> UIButton {
        let bt = UIButton()
        bt.setTitle(title, for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .bold)
        bt.titleLabel?.textColor = .white
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        return bt
    }
    
    static func attributedButton(_ firstPart: String, _ secondPart: String, withTextSize size: CGFloat) -> UIButton {
        let bt = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: " "))
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        bt.setAttributedTitle(attributedTitle, for: .normal)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return bt
    }
    
    
    
    static func orLine(withText title: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let dividerViewFirst = UIView()
        dividerViewFirst.backgroundColor = .white
        dividerViewFirst.alpha = 0.3
        dividerViewFirst.setHeight(height: 0.5)
        
        let dividerViewSecond = UIView()
        dividerViewSecond.backgroundColor = .white
        dividerViewSecond.alpha = 0.3
        dividerViewSecond.setHeight(height: 0.5)
        
        let orLabel = UILabel()
        orLabel.text = title
        orLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        orLabel.textColor = .white
        
        view.addSubview(dividerViewFirst)
        view.addSubview(orLabel)
        view.addSubview(dividerViewSecond)
        
        orLabel.center(inView: view)
        dividerViewFirst.centerY(inView: view, leadingAnchor: view.leadingAnchor, trailingAnchor: orLabel.leadingAnchor, paddingRight: -10)
        dividerViewSecond.centerY(inView: view, leadingAnchor: orLabel.trailingAnchor, paddingLeft: 10, trailingAnchor: view.trailingAnchor)
        
        return view
    }
}
