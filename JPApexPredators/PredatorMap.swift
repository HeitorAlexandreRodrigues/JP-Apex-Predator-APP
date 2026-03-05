//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Heitor Rodrigues on 05/03/26.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
   let predators = Predators()
    
    @State var position: MapCameraPosition
   
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(.imagery(elevation: .realistic))
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate:
            Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80, ))
    )
    .preferredColorScheme(.dark)
}
