//
//  ListView.swift
//  People Map
//
//  Created by Nikola Rogers on 4/13/23.
//

import SwiftUI
import MapKit

struct ListView: View {
    @Binding var peopleList: [AnnotationItem]
    
    var body: some View {
        VStack {
            Text("Your Contacts:")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            List(peopleList, id: \.locationName) { AnnotationItem in
                Text(AnnotationItem.locationName + ": " + AnnotationItem.personName)
            }
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
