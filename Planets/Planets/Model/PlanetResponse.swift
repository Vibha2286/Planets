//
//  PlanetResponse.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import Foundation

/// Planet response model
struct PlanetResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]
}
