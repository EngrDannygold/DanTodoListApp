//
//  TaskModel.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 23/06/2025.
//

import Foundation
import RealmSwift

struct TaskModel {
    var id: String
    var category: CategoryModel
    var caption: String
    var date: Date
    var isComplete: Bool
}
class LocalTaskModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var category: CategoryModel = CategoryModel.Study
    @Persisted var caption: String = ""
    @Persisted var date: Date = Date()
    @Persisted var isComplete: Bool = false
}
