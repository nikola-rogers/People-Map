//
//  AddView.swift
//  People Map
//
//  Created by Nikola Rogers on 4/13/23.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Binding var peopleList: [AnnotationItem]
    
    @State private var newName = ""
    @State private var newLocationName = ""
    @State private var newLatitude = 0.0
    @State private var newLongitude = 0.0
    
    var body: some View {
        VStack {
            Text("Add New Person:")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            HStack {
                TextField("Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } .padding()
            
            HStack {
                TextField("Location", text: $newLocationName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } .padding()
            
            Button(action: addPerson) {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
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
                
                let newPerson = AnnotationItem(locationName: newLocationName, personName: newName, latitude: tempCoordinate.latitude, longitude: tempCoordinate.longitude)
                peopleList.append(newPerson)
                
                newName = ""
                newLocationName = ""
                newLatitude = 0.0
                newLongitude = 0.0
            }
        }
    }
}


//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView(peopleList: [AnnotationItem])
//    }
//}
