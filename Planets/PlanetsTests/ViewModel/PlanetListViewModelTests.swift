//
//  PlanetListViewModelTests.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/22.
//

import XCTest
import CoreData
@testable import Planets

struct InvalidPayload: Codable {
    let count: String?
    let previous: String?
    let results: [Results]
}

class PlanetListViewModelTests: XCTestCase {

    private var systemUnderTest: PlanetListViewModel!
    private var dataManager: MockCoreDataManager!
    private var mockAPIClient: MockedAPIClient!
    
    override func setUpWithError() throws {
        // Initialize View Model
        dataManager = MockCoreDataManager()
        mockAPIClient = MockedAPIClient()
        systemUnderTest = PlanetListViewModel(client: mockAPIClient, dataManager: dataManager)
    }
    
    override func tearDownWithError() throws {
        systemUnderTest = nil
        dataManager = nil
    }
    
    func testOffileListDisplay() {
        XCTAssertEqual(dataManager.fetchAllPlanets(), [])
        if let entity = NSEntityDescription.entity(forEntityName: "Planet", in: dataManager.mockContainer.viewContext) {
            let planet = NSManagedObject(entity: entity, insertInto: dataManager.mockContainer.viewContext)
            planet.setValue("NewPlanet", forKey: "name")
        }
        XCTAssertEqual(dataManager.fetchAllPlanets().count, 1)
        systemUnderTest.fetchPlanets()
    }

    func testFetchPlanetDataSuccess() {
        
        XCTAssertEqual(dataManager.fetchAllPlanets().count, 0)
        XCTAssertEqual(systemUnderTest.errorState, .none)
        //Call API
        let promise = expectation(description: "Success Response from fetching Data")
        mockAPIClient.fetch(with: nil, page: nil, dataType: PlanetResponse.self) { result in
            switch result {
            case .success(let payload):
                XCTAssertEqual(payload.count, 60)
                XCTAssertEqual(payload.next, "https://swapi.dev/api/planets/?page=2")
                XCTAssertEqual(payload.results.count, 10)
                promise.fulfill()
            case .failure(let error):
                XCTFail("Unexpected Failure Response \(error.localizedDescription)")
            }
        }
        systemUnderTest.fetchPlanets()
        wait(for: [promise], timeout: 60)
        
    }
    
    func testFetchPlanetDataFailure() {
        //Call API
        let promise = expectation(description: "Failure Response from fetching Data")
        
        mockAPIClient.fetch(with: nil, page: nil, dataType: InvalidPayload.self) { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected Success Response")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.decoding)
                promise.fulfill()
            }
        }
        systemUnderTest.currentPage = 1000
        systemUnderTest.fetchPlanets()
        wait(for: [promise], timeout: 60)
    }
}
