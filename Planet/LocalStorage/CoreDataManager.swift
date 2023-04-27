//
//  CoreDataManager.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 25/04/2023.
//


import CoreData
class CoreDataManager {
    static let shared = CoreDataManager()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Planet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
