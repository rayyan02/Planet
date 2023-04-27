//
//  PlanetApp.swift
//  Planet
//
//  Created by Syed Rayyan Hasnain on 27/04/2023.
//

import SwiftUI

@main
struct PlanetApp: App {
    
    init() {
        NetworkMonitor.shared.startMonitoring()
    }
    var body: some Scene {
        WindowGroup {
            PlanetListScreen()
        }
    }
}
