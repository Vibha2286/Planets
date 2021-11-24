//
//  Results.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/19.
//

import Foundation

/// Model struct
struct Results: Hashable, Codable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
}
