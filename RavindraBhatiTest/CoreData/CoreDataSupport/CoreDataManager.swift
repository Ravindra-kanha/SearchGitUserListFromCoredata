//  CoreDataManager.swift
//  RavindraBhatiSwiftApp
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Apple. All rights reserved.


import Foundation
import CoreData

class CoreDataManager{
    
    //MARK: Properties
    lazy var manageObjectContext: NSManagedObjectContext = {
        return CoreDataManager.shared.persistentContainer.viewContext
    }()
    
    //Share Instance to access in other classes.
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RavindraBhatiTest")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    init(){
    }
    
    /// Save Information in the Core Data Model.
    func saveContext(){
        let context = manageObjectContext
        if context.hasChanges{
            do {
                try context.save()
            } catch let saveError{
                print("Failed to save: ", saveError)
            }
        }
    }
        

    
    /// Get Data With Specific Condition and Predicates on the Model of Core data.
    /// - Parameters:
    ///   - type: type of Model  or Entity Type which is stored in core data.
    ///   - search: Predicate to search a specific  data from the core-data Model.
    ///   - sort: by the using predicate on the Core data model to retrieve Information from the Local Data base,
    ///   - multiSort: To Apply multiple Operation on the core data model to get variant Result.
    /// - Returns: apply operation and give exact result from the core data.
    func query<T: NSManagedObject>(_ type : T.Type, search: NSPredicate?, sort: NSSortDescriptor? = nil, multiSort: [NSSortDescriptor]? = nil) -> [T]? {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        if let predicate = search{
            request.predicate = predicate
        }
        if let sortDescriptors = multiSort{
            request.sortDescriptors = sortDescriptors
        }
        else if let sortDescriptor = sort{
            request.sortDescriptors = [sortDescriptor]
        }
        do{
            return try manageObjectContext.fetch(request)
        }catch{
            print("Error with request: \(error)")
            return []
        }
    }
}
