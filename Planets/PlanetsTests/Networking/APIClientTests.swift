//
//  PlanetsTests.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/23.
//

import XCTest
@testable import Planets

class APIClientTests: XCTestCase {
    
    private var systemUnderTest: APIClient!
    
    override func setUpWithError() throws {
        systemUnderTest = APIClient()
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    // MARK: Asynchronous Tests: API Call
    
    func testValidCallToAPIReturnsCompletion() {
        let url = URL(string: "https://swapi.dev/api/planets/?page=1")
        let promise = expectation(description: "Returns complition handler")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = systemUnderTest.session.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        
        systemUnderTest.fetch(with: nil, page: nil, dataType: PlanetResponse.self) { (result) in
            switch result {
            case .success(let payload):
                XCTAssertEqual(payload.count, 60)
                XCTAssertEqual(payload.next, "https://swapi.dev/api/planets/?page=2")
                XCTAssertEqual(payload.results.count, 10)
            case .failure(let error):
                XCTFail("Unexpected Failure Response \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 60)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
        
    }
    
    func testValidCallToAPIReturnsFailedCompletion() {
        let url = URL(string: "https://swapi.dev/api/planets/?page=-1")
        let promise = expectation(description: "Returns failed complition handler")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = systemUnderTest.session.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        
        systemUnderTest.fetch(with: nil, page: -1, dataType: PlanetResponse.self) { (result) in
            switch result {
            case .success(_):
                XCTFail("Unexpected Failure Response")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.network)
            }
        }
        
        wait(for: [promise], timeout: 60)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 404)
       
    }
    
    func testValidCallToAPIReturnsFailedCompletionWithEmptyRequest() {
        let url = URL(string: "")
        let promise = expectation(description: "Returns failed complition handler")
        
        var statusCode: Int?
        
        let dataTask = systemUnderTest.session.dataTask(with: url ?? URL(fileURLWithPath: "")) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        dataTask.resume()
        
        systemUnderTest.fetch(with: url, page: nil, dataType: PlanetResponse.self) { (result) in
            switch result {
            case .success(_):
                XCTFail("Unexpected Failure Response")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.request)
            }
        }
        
        wait(for: [promise], timeout: 60)
        XCTAssertEqual(statusCode, nil)
    }
}
