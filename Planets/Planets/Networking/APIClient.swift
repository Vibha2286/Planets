//
//  APIClient.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import SwiftUI

final class APIClient {
    
    /// API url
    private let baseUrlString = "https://swapi.dev/api/planets/"
    /// URL session object
    let session: URLSession
    
    /// Base API url
    private lazy var baseUrl: URL = {
        return URL(string: baseUrlString)!
    }()
    
    /// Initialize session object
    /// - Parameter session: session object
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

// MARK: - Network client protocol method

extension APIClient: APIClientProtocol {
    
    /// Fetch list of planet depending on page number
    /// - Parameters:
    ///   - url: API url
    ///   - page: page number
    ///   - dataType: generic data type
    ///   - completion: completion handler with response
    func fetch<T: Decodable>(with url: URL?, page: Int?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request: URL = baseUrl
        
        // If URL then exists use it
        if let url = url { request = url }
        
        // API Pagination: there are multiple pages of results...
        if let page = page {
            // ... create url string with the corresponding page number
            let urlString = baseUrlString + "?page=\(page)"
            guard let url = URL(string: urlString) else { return }
            request = url
        }
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.request))
                }
                return
            }
            // Check if http response is successful and data is safe
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  let safeData = data
            else {
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
                return
            }
            
            switch statusCode {
            case 200...299:
                do {
                    let decodedData = try JSONDecoder().decode(dataType, from: safeData)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding))
                    }
                }
            default :
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
        }
        dataTask.resume()
    }
}
