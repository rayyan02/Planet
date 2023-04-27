//
//  PlanelListViewModel.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 24/04/2023.
//

import Foundation
import SwiftUI

class PlanetListViewModel: ObservableObject {
    @Published var planets = [String] ()
    
    func getPlanets() {
        if NetworkMonitor.shared.isConnected {
            fetchPlanetsfromServer()
        } else {
            fetchPlanetsfromDB()
        }
    }
    
    // Fetches Planets from the server
    private func fetchPlanetsfromServer() {
        PlanetDataManager.shared.fetchPlanets { [weak self] result in
            switch result {
            case .success(let planets):
                self?.planets = planets.results.map({$0.name})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Fetches Planets from the Coredata
    private func fetchPlanetsfromDB() {
        if let planets = PlanetDataManager.shared.fetchCoreDataPlanets() {
            self.planets = planets.map({$0.name ?? ""})
        }
    }
}
