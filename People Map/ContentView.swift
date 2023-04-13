//
//  ContentView.swift
//  People Map
//
//  Created by Nikola Rogers on 4/4/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 39.828494188286946, longitude: -98.5794689734475), latitudinalMeters: 7500000, longitudinalMeters: 7500000)
    
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
