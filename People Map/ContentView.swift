//
//  ContentView.swift
//  People Map
//
//  Created by Nikola Rogers on 4/4/23.
//

import SwiftUI
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let locationName: String
    let personName: String
    let latitude: Double
    let longitude: Double
}

struct ContentView: View {
    
    @State private var peopleList: [AnnotationItem] = []
    
    var body: some View {
        TabView {
            MapView(peopleList: $peopleList)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            AddView(peopleList: $peopleList)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
            
            ListView(peopleList: $peopleList)
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("List")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
