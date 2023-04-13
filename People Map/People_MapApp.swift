//
//  People_MapApp.swift
//  People Map
//
//  Created by Nikola Rogers on 4/4/23.
//

import SwiftUI

@main
struct People_MapApp: App {
    var body: some Scene {
        WindowGroup {
            MapAnnotations(peopleList: [])
        }
    }
}
