//
//  UIView.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 03/07/2025.
//

import Foundation
import UIKit

extension UIView {
    func tapBounceButtonAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut]) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut]) {
                self.transform = CGAffineTransform.identity
            }
        }
        
    }
    func shakeViewAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
        animation.duration = 0.4
        animation.repeatCount = 1
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
    func presentViewBounceAnimation() {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 6, options: [.curveEaseOut]) {
            self.transform = CGAffineTransform.identity
        }
    }
}

