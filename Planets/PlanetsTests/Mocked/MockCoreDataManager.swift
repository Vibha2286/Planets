//
//  MockCoreDataManager.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/22.
//

import XCTest
import CoreData
@testable import Planets

class MockCoreDataManager: CoreDataManager {
    
    override init() {
        super.init()
        persistentContainer = mockContainer
    }

   lazy var mockContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Planets")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false
    
    container.persistentStoreDescriptions = [description]
    
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        precondition(storeDescription.type == NSInMemoryStoreType)
           if let error = error as NSError? {
               print("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()
}
