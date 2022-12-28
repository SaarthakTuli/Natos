//
//  NatosApp.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import SwiftUI

@main
struct NatosApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
