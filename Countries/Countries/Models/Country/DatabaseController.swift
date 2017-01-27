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
    
    let entityName = String(describing: Country.self)
    
     // MARK: - Initialization
    
    static let sharedInstance = DatabaseController()
    
    private init() {
        
    }
    
     // MARK: - Public
    
    func getMainContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func findEntities() -> [Country]? {
        let fetchRequest: NSFetchRequest = Country.fetchRequest()
        do {
            let country = try self.getMainContext().fetch(fetchRequest)
            return country
        } catch {
            return nil
        }
    }
    
    func findEntity(in context: NSManagedObjectContext, predicate: String? = nil) -> NSManagedObject? {
        let fetchRequest: NSFetchRequest = Country.fetchRequest()
        let predicate = NSPredicate(format: "countrieName = %@", predicate!)
        fetchRequest.predicate = predicate
        do {
            let country = try context.fetch(fetchRequest)
            return country.first
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }

    func findOrCreateEntity(context: NSManagedObjectContext, predicate: String?) -> NSManagedObject? {
        let result = self.findEntity(in: context, predicate: predicate)
        if let country = result {
            return country
        } else {
            return self.createCountryWithName(name: predicate!, context: context)
        }
    }
    
    func createCountryWithName(name: String, context: NSManagedObjectContext) -> NSManagedObject? {
        let object = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context)
        object.setValue(name, forKey: "countrieName")
        
        return object
    }
    
    func deleteAll() {
        let objects = self.findEntities()
        for object in objects! {
            self.getMainContext().delete(object)
        }
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
