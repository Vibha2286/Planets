//
//  CoreDataManager.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/20.
//

import Foundation
import CoreData

/// Database interactor layer to perform the operaton on the database
class CoreDataManager {
    
    var persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Planets")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialise Core Data Stack \(error)")
            }
        }
    }
}

//MARK: - Core data manager protocol methods
//extension of CoreDataManager to handle to planet methods

extension CoreDataManager: CoreDataManagerProtocol {
    
    /// Method to save planets into the current context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// Method to fetch all planets
    /// - Returns: planet array
    func fetchAllPlanets() -> [Planet] {
        return fetchAll()
    }
    
    ///generic method which can reuse when there are  more than one kind of object
    private func fetchAll<T: NSManagedObject>() -> [T] {
        let name = String(describing: T.self)
        
        let fetchRequest = NSFetchRequest<T>(entityName: name)
        var foundItems = [T]()
        
        self.persistentContainer.viewContext.performAndWait {
            foundItems = try! fetchRequest.execute()
        }
        
        return foundItems
    }
    
    /// Method to save planets
    /// - Parameter data: result data object
    func savePlanet(data: Results) {
        let context = self.persistentContainer.viewContext
        
        if let planetEntity = NSEntityDescription.insertNewObject(forEntityName: "Planet", into: context) as? Planet {
            planetEntity.name = data.name
            planetEntity.created = data.created
            planetEntity.climate = data.climate
            planetEntity.edited = data.edited
            planetEntity.gravity =  data.gravity
            planetEntity.terrain =  data.terrain
            planetEntity.url =  data.url
            planetEntity.population = data.population
            planetEntity.orbitalPeriod =  data.orbital_period
            planetEntity.diameter =  data.diameter
            planetEntity.rotationPeriod =  data.rotation_period
            planetEntity.surfaceWater =  data.surface_water
            planetEntity.films =  data.films
            planetEntity.residents =  data.residents
        }
        self.saveContext()
    }
    
    /// Method to get the list of planets
    /// - Returns: planets array
    func getPlanetsData() -> [Results] {
        var planets: [Results] = []
        for planet in fetchAllPlanets() {
            let resultData = Results(name: planet.name,
                                     rotation_period: planet.rotationPeriod,
                                     orbital_period: planet.orbitalPeriod ,
                                     diameter: planet.diameter,
                                     climate: planet.climate,
                                     gravity: planet.gravity,
                                     terrain: planet.terrain,
                                     surface_water: planet.surfaceWater,
                                     population: planet.population,
                                     residents: planet.residents,
                                     films: planet.films,
                                     created: planet.created,
                                     edited: planet.edited,
                                     url: planet.url)
            
            planets.append(resultData)
        }
        return planets
    }
    
    /// Method to check entity attritute is already present or not in the database
    /// - Parameter name: planet name
    /// - Returns: true/false
    func isEntityAttributeExist(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        let res = try! viewContext.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
}
