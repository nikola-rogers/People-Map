//
//  TabBar.swift
//  People Map
//
//  Created by Nikola Rogers on 4/10/23.
//

import SwiftUI

enum Tabs: Int {
    case map = 0
    case add = 1
    case list = 2
}

struct TabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack (alignment: .center, spacing: 100) {
            
            Button {
                // switches to map
                
                selectedTab = .map
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "map")
                    Text("Map")
                }
            }
            
            Button {
                // adds a new person to map
                
                selectedTab = .add
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
            }
            
            Button {
                // provides list view of all people
                
                selectedTab = .list
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "list.clipboard")
                    Text("List")
                }
            }
            
        }
        .frame(height: 82)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.map))
    }
}
