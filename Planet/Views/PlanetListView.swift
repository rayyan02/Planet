//
//  PlanetListView.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 24/04/2023.
//

import SwiftUI

struct PlanetListView: View {
    let planets: [String]
    
    var body: some View {
        List(self.planets, id:\.self) { planet in
            Text(planet)
                .font(.title)
        }
    }
}
