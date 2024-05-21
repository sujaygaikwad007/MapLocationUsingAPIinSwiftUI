//
//  MapLocationUsingAPIApp.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import SwiftUI

@main
struct MapLocationUsingAPIApp: App {
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
