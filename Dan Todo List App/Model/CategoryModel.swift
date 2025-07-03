//
//  CategoryModel.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 22/06/2025.
//

import Foundation
import UIKit

enum CategoryModel: String, CaseIterable {
case Work, Study, Exercise
    
    var color: UIColor {
        switch self {
        case .Exercise:
            return UIColor.Exercise
        case .Work:
            return UIColor.Work
        case .Study:
            return UIColor.Study
        }
    }
    var secondaryColor: UIColor {
        switch self {
            
        case .Work:
            return UIColor.SecondayWork
        case .Study:
            return UIColor.SecondayStudy
        case .Exercise:
            return UIColor.SecondayExercise

        }
    }
}
