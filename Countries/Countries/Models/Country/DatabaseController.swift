//
//  DatabaseController.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/26/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    
    private init() {
        
    }
    
    class func getContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    class func fetchEntity<T: NSManagedObject>(type: T.Type)  -> Array<T> {
        return self.fetchEntityIn(context: self.getContext(), type: type)
    }
    
    class func fetchEntityIn<T: NSManagedObject>(context: NSManagedObjectContext, type: T.Type) -> Array<T> {
        
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T> /////////////убарть и сделать универсальным
        let descriptor = NSSortDescriptor(key: "countrieName", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]

        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            let array:Array<T> = []
            print("Fetch error: \(error)")
            return array
        }
    }
    
    class func deleteAll<T: NSManagedObject>(entityType: T.Type) {
        let context = self.getContext()
        let objects = self.fetchEntityIn(context: context, type: entityType)
        for object in objects {
            context.delete(object)
        }
    }
    
    class func createEntityIn(context: NSManagedObjectContext, name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: context)
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Countries")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
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
