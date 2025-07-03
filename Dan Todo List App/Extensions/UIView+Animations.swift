//
//  UIView.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 03/07/2025.
//

import Foundation
import UIKit

extension UIView {
    func tapBounceButton() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut]) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut]) {
                self.transform = CGAffineTransform.identity
            }
        }

    }
}
