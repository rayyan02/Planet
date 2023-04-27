//
//  PlanetListScreen.swift
//  PlanetApp
//
//  Created by Syed Rayyan Hasnain on 24/04/2023.
//

import SwiftUI

struct PlanetListScreen: View {
    
    @ObservedObject var planetViewModel: PlanetListViewModel
    
    init() {
        planetViewModel = PlanetListViewModel()
        planetViewModel.getPlanets()
    }
    
    var body: some View {
        NavigationView {
            VStack{
                PlanetListView(planets: planetViewModel.planets)
            }
            .navigationBarTitle("Planets")
        }
    }
}

struct PlanetListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListScreen()
    }
}
