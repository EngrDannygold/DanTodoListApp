//
//  Extension+Colors.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 28/06/2025.
//

import Foundation
import UIKit

extension UIColor {
    static var Work: UIColor {
        return UIColor(named: "Work")!
    }
    static var SecondayWork: UIColor {
        return UIColor(named: "Work")!.withAlphaComponent(0.2)
    }
    static var Exercise: UIColor {
        return UIColor(named: "Exercise")!
    }
    static var SecondayExercise: UIColor {
        return UIColor(named: "Exercise")!.withAlphaComponent(0.2)
    }
    static var Study: UIColor {
        return UIColor(named: "Study")!
    }
    static var SecondayStudy: UIColor {
        return UIColor(named: "Study")!.withAlphaComponent(0.2)
    }
}
