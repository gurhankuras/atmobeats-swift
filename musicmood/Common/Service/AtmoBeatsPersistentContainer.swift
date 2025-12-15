//
//  AtmoBeatsPersistentContainer.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import CoreData

class AtmoBeatsPersistentContainer {
    let persistentContainer: NSPersistentContainer

    let writerContext: NSManagedObjectContext

    static var preview: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "atmobeats")
        container.persistentStoreDescriptions.first?.url = URL(
            fileURLWithPath: "/dev/null"
        )
        container.loadPersistentStores { (description, error) in

        }
        return container.viewContext
    }

    init() {
        self.persistentContainer = NSPersistentContainer(name: "atmobeats")

        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        writerContext = persistentContainer.newBackgroundContext()
        writerContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        writerContext.name = "writerContext"
    }
}
