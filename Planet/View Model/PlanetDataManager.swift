//
//  DataManager.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 25/04/2023.
//

import Foundation
import CoreData

struct APIEnpoints {
    public static let planets = "planets/"
}

final class PlanetDataManager {
    static let shared = PlanetDataManager()
    private lazy var networkService = NetworkService(session: URLSession(configuration: .default))
    
    ///  Fetches planets from the server and store in coredata
    func fetchPlanets(completionHandler:@escaping (Result<Planets, NetworkError>) -> Void) {
        let request = Request(url: "\(NetworkConstants.baseURL + APIEnpoints.planets)")
        networkService.dataTask(request: request) { (response) in
            guard (response?.error) != nil else {
                if let data = response?.data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Planets.self, from: data)
                        if !self.alreadyStoredInCoreData() {
                            self.storeinCoreData(planets: response)
                        }
                        Dispatch.DispatchQueue.main.async {
                            completionHandler(.success(response))
                        }
                    } catch {
                        return
                    }
                } else {
                    return completionHandler(.failure(.error))
                }
                return
            }
            return completionHandler(.failure(.error))
        }
    }
}

extension PlanetDataManager {
    /// Store category data in coredata
    /// - Parameters:
    ///   - planets:
    private func storeinCoreData(planets: Planets) -> Void {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        for item in planets.results {
            let planet = Planet(context: context)
            planet.name = item.name
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
    }
    
    /// Checks if data already exist in coredata
    private func alreadyStoredInCoreData() -> Bool {
        if let planet = fetchCoreDataPlanets() {
            return planet.count > 0
        }
        return false
    }
    
    // Fetches planets from coredata
    func fetchCoreDataPlanets() -> [Planet]? {
        let planetsFetch: NSFetchRequest<Planet> = Planet.fetchRequest()
        do {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let results = try context.fetch(planetsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
}
