//
//  HomeShelfApp.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI
import CoreData

@main
struct HomeShelfApp: App {
    
    @StateObject private var manager: DataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
