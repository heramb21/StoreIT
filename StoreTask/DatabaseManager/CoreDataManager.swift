//
//  CoreDataManager.swift
//  StoreTask
//
//  Created by Mac on 04/07/18.
//  Copyright © 2018 Me. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Manager(Helper) Class For Core Data
class CoreDataManager: NSManagedObject {
    
    // MARK: - For Creating Record  In Given Entity
    func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject?
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
    
    // MARK: - For Fetching Record In Given Entity 
    func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
}
