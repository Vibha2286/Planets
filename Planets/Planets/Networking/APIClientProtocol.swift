//
//  APIClientProtocol.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import Foundation

/// API client protocol methods for fetching the data
protocol APIClientProtocol {
    func fetch<T: Decodable>(with url: URL?, page: Int?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}
