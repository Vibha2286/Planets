//
//  CoreDataManagerProtocol.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/20.
//

import Foundation

/// Core data protocol methods
protocol CoreDataManagerProtocol {
    func saveContext ()
    func fetchAllPlanets() -> [Planet]
    func savePlanet(data: Results)
    func getPlanetsData() -> [Results]
    func isEntityAttributeExist(name: String) -> Bool
}
