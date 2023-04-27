//
//  PlanelModel.swift
//  MoviesApp
//
//  Created by Syed Rayyan Hasnain on 23/04/2023.
//

import Foundation

// MARK: - Planets
struct Planets: Codable {
    let count: Int
    let next: String
    let results: [ResultModel]
}

// MARK: - Result
struct ResultModel: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
