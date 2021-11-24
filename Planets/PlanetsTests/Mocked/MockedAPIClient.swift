//
//  MockedAPIClient.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/22.
//

import XCTest
@testable import Planets

class MockedAPIClient: APIClientProtocol {
    
    func fetch<T>(with url: URL?, page: Int?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        if page == 1000 {
            completion(.failure(.decoding))
            return
        }
        
        guard let url = Bundle(for: MockedAPIClient.self).url(forResource: "PlanetsStub", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return  completion(.failure(.request))
        }
            do {
                let decodedData = try JSONDecoder().decode(dataType, from: data)

                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decoding))
                }
            }
    }
}
