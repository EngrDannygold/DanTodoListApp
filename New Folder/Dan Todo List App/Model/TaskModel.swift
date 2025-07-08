//
//  TaskModel.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 23/06/2025.
//

import Foundation

struct TaskModel {
    var id: String
    var category: CategoryModel
    var caption: String
    var date: Date
    var isComplete: Bool
}
