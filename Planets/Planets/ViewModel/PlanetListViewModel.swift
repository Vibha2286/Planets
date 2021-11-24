//
//  PlanetListViewModel.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/20.
//

import SwiftUI
import CoreData

/// View model for planet list
final class PlanetListViewModel: ObservableObject {
    
    //don't want anyone to change the viewmodel data directly, hence all private

    private(set) var apiClient: APIClientProtocol
    private var total = 0
    private(set) var errorState = NetworkError.none
    private var dataManager: CoreDataManagerProtocol
    
    @Published var currentPage = 1
    @Published var isLoading: Bool = true
    @Published var planets: [Results] = []
    
    /// Initilize view model
    /// - Parameters:
    ///   - client: api client object
    ///   - dataManager: database object
    init(client: APIClientProtocol, dataManager: CoreDataManagerProtocol) {
        self.apiClient = client
        self.dataManager = dataManager
    }
    
    /// Fetch planet data from API
    func fetchPlanets() {
        
      /*   //Added logic to fetch planets when database is empty
        guard dataManager.fetchAllPlanets().isEmpty else {
            self.isLoading = false
            self.planets = dataManager.getPlanetsData()
            return
        } */
        apiClient.fetch(with: nil, page: currentPage, dataType: PlanetResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                // Perform on main thread to update UI
                DispatchQueue.main.async {
                    self.fetchPlanetsSuccess(response: response)
                }
            case .failure(_):
                self.fetchPlanetsFailure()
            }
        }
    }
    
    /// Planet response success method
    /// - Parameter response: reponse object
    private func fetchPlanetsSuccess(response: PlanetResponse) {
        // Store total number of characters available on the server
        self.total = response.count ?? 0
        self.errorState = .none
        self.planets.append(contentsOf: response.results)
        self.savePlanetsData()
        self.isLoading = false
    }
    
    /// Called when planets api failed and fetch from database incase offline as well
    private func fetchPlanetsFailure() {
        self.isLoading = false
        self.planets = self.dataManager.getPlanetsData()
        self.errorState = .network
    }
    
    /// we can call this function to enhance functionlity in future by load more list so as of now it is private because I am not using it
    private func loadMore() {
        // Uncomment code when load more datata and Increment the page number to fetch the next page of results
        self.isLoading = true
        self.currentPage += 1
        fetchPlanets()
    }
    
    /// Save planet to database and ignore duplicate record
    private func savePlanetsData() {
        for planet in planets {
            if !dataManager.isEntityAttributeExist(name: planet.name) {
                dataManager.savePlanet(data: planet)
            }
        }
    }
}
