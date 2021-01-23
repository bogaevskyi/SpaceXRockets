//
//  CoreDataService.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import CoreData

final class CoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SpaceXRockets")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save() {
        let context = persistentContainer.viewContext
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

