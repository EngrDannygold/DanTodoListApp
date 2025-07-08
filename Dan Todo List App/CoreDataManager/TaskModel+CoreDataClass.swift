//
//  TaskModel+CoreDataClass.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 08/07/2025.
//
//

import Foundation
import CoreData
import UIKit

@objc(TaskModel)
public class TaskModel: NSManagedObject {
    var categoryEnum: CategoryModel {
        get {
            return CategoryModel(rawValue: category) ?? .Study
        }
        set {
            category = newValue.rawValue
        }
    }
    var color: UIColor {
        return categoryEnum.color
    }
    var secondaryColor: UIColor {
        return categoryEnum.secondaryColor
    }
}
