//
//  CoreDataManagerTests.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/23.
//

import XCTest
import CoreData
@testable import Planets

class CoreDataManagerTests: XCTestCase {
    
    private var dataManager: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        dataManager = MockCoreDataManager()
    }

    override func tearDownWithError() throws {
        dataManager = nil
    }
    
    func testSaveContext() {
        if let entity = NSEntityDescription.entity(forEntityName: "Planet", in: dataManager.mockContainer.viewContext) {
            let planet = NSManagedObject(entity: entity, insertInto: dataManager.mockContainer.viewContext)
            planet.setValue("NewPlanet", forKey: "name")
        }
        
        XCTAssertNoThrow(dataManager.saveContext())
    }
    
    func testFetchAllPlanets() {
        XCTAssertEqual(dataManager.fetchAllPlanets(), [])
        if let entity = NSEntityDescription.entity(forEntityName: "Planet", in: dataManager.mockContainer.viewContext) {
            let planet = NSManagedObject(entity: entity, insertInto: dataManager.mockContainer.viewContext)
            planet.setValue("NewPlanet", forKey: "name")
        }
        XCTAssertEqual(dataManager.fetchAllPlanets().count, 1)
    }
 
    func testSavePlanet() {
        let planet = Results(name: "Bespin",
                             rotation_period: "12",
                             orbital_period: "5110" ,
                             diameter: "118000",
                             climate: "temparte",
                             gravity: "1 Standard",
                             terrain: "gas gaint",
                             surface_water: "0",
                             population: "6000000",
                             residents: ["https://swapi.dev/api/people/1/"],
                             films: ["https://swapi.dev/api/films/1/"],
                             created: "2014-12-09T13:50:49.641000Z",
                             edited: "2014-12-20T20:58:18.411000Z",
                             url: "https://swapi.dev/api/planets/1/")
            
        dataManager.savePlanet(data: planet)
        
        XCTAssertEqual(dataManager.fetchAllPlanets().count, 1)
        let getPlanet = dataManager.fetchAllPlanets()[0]
        
        XCTAssertEqual(getPlanet.name, "Bespin")
        XCTAssertEqual(getPlanet.rotationPeriod, "12")
        XCTAssertEqual(getPlanet.orbitalPeriod, "5110")
        XCTAssertEqual(getPlanet.diameter, "118000")
        XCTAssertEqual(getPlanet.climate, "temparte")
        XCTAssertEqual(getPlanet.gravity, "1 Standard")
        XCTAssertEqual(getPlanet.terrain, "gas gaint")
        XCTAssertEqual(getPlanet.surfaceWater, "0")
        XCTAssertEqual(getPlanet.population, "6000000")
    }
}
