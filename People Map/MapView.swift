//
//  MapView.swift
//  People Map
//
//  Created by Nikola Rogers on 4/13/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.828494188286946, longitude: -98.5794689734475), latitudinalMeters: 7500000, longitudinalMeters: 7500000)
    @Binding var peopleList: [AnnotationItem]
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, annotationItems: peopleList) { item in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude), tint: .red)
                }
                .padding(.bottom, 90.0)
                    .ignoresSafeArea()
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
