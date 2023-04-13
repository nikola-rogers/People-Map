//
//  MapAnnotations.swift
//  People Map
//
//  Created by Nikola Rogers on 4/4/23.
//

import SwiftUI
import MapKit


class AnnotationItem: Identifiable, Codable {
    let id = UUID()
    let locationName: String
    let personName: String
    let latitude: Double
    let longitude: Double
        
    enum CodingKeys: String, CodingKey {
        case id
        case locationName
        case personName
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locationName = try container.decode(String.self, forKey: .locationName)
        personName = try container.decode(String.self, forKey: .personName)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }

}
    
struct AddView: View {
    @State var peopleList: [AnnotationItem]
    
    @State private var newName = ""
    @State private var newLocationName = ""
    @State private var newLatitude = 0.0
    @State private var newLongitude = 0.0
    
    var body: some View {
        VStack {
            Text("Add New Person")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            TextField("Name", text: $newName)
            TextField("Location", text: $newLocationName)
            
            Button(action: addPerson) {
                Text("Add")
            }
        }
    }
    
    private func addPerson() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = newLocationName
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard let response = response else {
                print("Error in finding location")
                return
            }
            
            if let mapItem = response.mapItems.first {
                let tempCoordinate = mapItem.placemark.coordinate
                
//                let newPerson = AnnotationItem(from: Decoder as! Decoder, locationName: newLocationName, personName: newName, latitude: tempCoordinate.latitude, longitude: tempCoordinate.longitude)
                let newPerson = try! JSONDecoder().decode(AnnotationItem.self, from: Data("""
                        {
                            "locationName": "\(newLocationName)",
                            "personName": "\(newName)",
                            "latitude": \(tempCoordinate.latitude),
                            "longitude": \(tempCoordinate.longitude)
                        }
                        """.utf8))

                peopleList.append(newPerson)
                
                newName = ""
                newLocationName = ""
                newLatitude = 0.0
                newLongitude = 0.0
            }
        }
    }
}

struct ListView: View {
    @State var peopleList: [AnnotationItem]
    
    var body: some View {
        List(peopleList, id: \.locationName) { AnnotationItem in
            Text(AnnotationItem.locationName + ": " + AnnotationItem.personName)
        }
    }
}

struct MapView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.828494188286946, longitude: -98.5794689734475), latitudinalMeters: 7500000, longitudinalMeters: 7500000)
    @State var peopleList: [AnnotationItem]
    
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

struct MapAnnotations: View {

@State var peopleList: [AnnotationItem] {
    didSet {
        let data = try? JSONEncoder().encode(peopleList)
        UserDefaults.standard.set(data, forKey: "peopleList")
    }
}

var body: some View {
        TabView {
            MapView(peopleList: peopleList)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            AddView(peopleList: peopleList)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
            
            ListView(peopleList: peopleList)
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("List")
                }
        }
    }
}

struct MapAnnotations_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotations(peopleList: [])
    }
}
