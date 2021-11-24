//
//  NetworkError.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

/// Network errors enum to check state of the error response
enum NetworkError: Error {
    case none
    case invalidUrl
    case request
    case decoding
    case network
    case unknown
    
    var reason: String {
        switch self {
        case .none:
            return "Success"
        case .invalidUrl:
            return "Network Failure: Invalid URL"
        case .request:
            return "Network Failure: Error occurred while fetching data"
        case .decoding:
            return "Network Failure: Error occurred while decoding data"
        case .network:
            return "Network Failure: Unsuccessful HTTP response"
        case .unknown:
            return "Network Failure"
        }
    }
}
