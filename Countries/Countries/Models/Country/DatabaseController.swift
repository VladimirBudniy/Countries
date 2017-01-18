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
    
    static let sharedInstance = DatabaseController()
    
    private init() {
        
    }
    
    func getMainContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetchEntities()  -> [Country] {
        return self.fetchEntitiesIn(context: self.getMainContext(), type: Country.self)
    }
    
    func fetchEntitiesIn<T: NSManagedObject>(context: NSManagedObjectContext, type: T.Type) -> Array<T> {
        let fetchRequest: NSFetchRequest<T> = type.fetchRequest() as! NSFetchRequest<T>
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
    
    func fetchEntity<T: NSManagedObject>(context: NSManagedObjectContext, name: String, type: T.Type) -> Country? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        do {
            let country = try context.fetch(fetchRequest).first
            return country as? Country
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }

    func deleteAll<T: NSManagedObject>(entityType: T.Type) {
        let context = self.getMainContext()
        let objects = self.fetchEntitiesIn(context: context, type: entityType)
        for object in objects {
            context.delete(object)
        }
    }
    
    func createCountryIn(context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: Country.self), into: context)
    }
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Countries")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = self.getMainContext()
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
