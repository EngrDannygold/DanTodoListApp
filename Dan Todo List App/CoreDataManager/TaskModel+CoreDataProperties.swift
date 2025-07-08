//
//  TaskModel+CoreDataProperties.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 08/07/2025.
//
//

import Foundation
import CoreData


extension TaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }

    @NSManaged public var category: String
    @NSManaged public var caption: String
    @NSManaged public var date: Date
    @NSManaged public var isComplete: Bool

}

extension TaskModel : Identifiable {

}
