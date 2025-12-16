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
        container.loadPersistentStores { _, _ in
        }
        return container.viewContext
    }

    init() {
        persistentContainer = NSPersistentContainer(name: "atmobeats")

        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        writerContext = persistentContainer.newBackgroundContext()
        writerContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        writerContext.name = "writerContext"
    }
}
