//
//  Extension+NSManagedObjectContext.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/3/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    static func mainContext() -> NSManagedObjectContext {
        return DatabaseController.sharedInstance.persistentContainer.viewContext
    }
    
    static func privateContext() -> NSManagedObjectContext {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = NSManagedObjectContext.mainContext()
        
        return privateContext
    }
    
    static func findEntities(in context: NSManagedObjectContext) -> [Country]? {
        let fetchRequest: NSFetchRequest = Country.fetchRequest()
        do {
            let countries = try context.fetch(fetchRequest)
            return countries
        } catch {
            return nil
        }
    }
    
    static func findEntity(in context: NSManagedObjectContext, predicate: String? = nil) -> NSManagedObject? {
        let fetchRequest: NSFetchRequest = Country.fetchRequest()
        let predicate = NSPredicate(format: "countryName = %@", predicate!)
        fetchRequest.predicate = predicate
        do {
            let country = try context.fetch(fetchRequest)
            return country.first
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }
    
    static func findOrCreateEntity(in context: NSManagedObjectContext, with predicate: String?) -> NSManagedObject? {
        let result = self.findEntity(in: context, predicate: predicate)
        if let country = result {
            return country
        } else {
            return self.createEntity(with: predicate!, in: context)
        }
    }
    
    static func createEntity(with name: String, in context: NSManagedObjectContext) -> NSManagedObject? {
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: Country.self), into: context)
        object.setValue(name, forKey: "countryName")
        
        return object
    }
    
    static func deleteAllInBackground() {
        self.deleteAll(in: NSManagedObjectContext.privateContext())
    }
    
    static func deleteAll(in context: NSManagedObjectContext) {
        let objects = self.findEntities(in: context)
        for object in objects! {
            context.delete(object)
        }
    }
    
    // MARK: - Core Data Saving support
    
    static func saveInContext(context: NSManagedObjectContext) {
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
