//
//  CoreDataStack.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 07/07/2025.
//

import Foundation
import CoreData

class Todolist {
    private let modelName: String
    
    lazy var managedContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        return context
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    static let shared = Todolist(modelName: "TodoList")
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = managedContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
