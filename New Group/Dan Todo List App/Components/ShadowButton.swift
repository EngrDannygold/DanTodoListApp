//
//  ShadowButton.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 02/07/2025.
//

import UIKit


@IBDesignable
class ShadowButton: UIButton {
    @IBInspectable
    var background: UIColor = .link {
        didSet {
            layer.backgroundColor = background.cgColor
        }
    }
    @IBInspectable
    var shadow: UIColor = .red {
        didSet {
            layer.shadowColor = shadow.cgColor
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = background
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0
        layer.shadowColor = UIColor(named: "SecondaryLink")!.cgColor
    }
    
}
